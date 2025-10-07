import { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers, fhevm } from "hardhat";
import { FhevmType, FhevmTypeEuint } from "@fhevm/hardhat-plugin";
import type { ContractTransactionResponse } from "ethers";

import { BoundedRandomLibHarness, BoundedRandomLibHarness__factory } from "../types";

describe("BoundedRandomLib", function () {
  let alice: HardhatEthersSigner;
  let harness: BoundedRandomLibHarness;
  let harnessAddress: string;

  before(async function () {
    [, alice] = await ethers.getSigners();
  });

  beforeEach(async function () {
    if (!fhevm.isMock) {
      this.skip();
    }

    const factory = (await ethers.getContractFactory("BoundedRandomLibHarness")) as BoundedRandomLibHarness__factory;
    harness = (await factory.deploy()) as BoundedRandomLibHarness;
    harnessAddress = await harness.getAddress();
  });

  const generateAndDecrypt = async (
    generator: () => Promise<ContractTransactionResponse>,
    getter: () => Promise<string>,
    fhevmType: FhevmType,
  ): Promise<bigint> => {
    const tx = await generator();
    await tx.wait();

    const handle = await getter();
    return fhevm.userDecryptEuint(fhevmType as FhevmTypeEuint, handle, harnessAddress, alice);
  };

  describe("boundedRandomUint8", function () {
    it("reverts when min is greater than max", async function () {
      await expect(harness.connect(alice).boundedRandomUint8(5, 4)).to.be.revertedWithCustomError(
        harness,
        "BoundedRandom_InvalidRange",
      );
    });

    it("returns values within the requested range", async function () {
      const min = 10;
      const max = 17;

      for (let i = 0; i < 6; i += 1) {
        const value = await generateAndDecrypt(
          () => harness.connect(alice).boundedRandomUint8(min, max),
          () => harness.connect(alice).getLastUint8(),
          FhevmType.euint8,
        );

        expect(value).to.be.gte(BigInt(min));
        expect(value).to.be.lte(BigInt(max));
      }
    });
  });

  describe("boundedRandomUint16", function () {
    it("reverts when min is greater than max", async function () {
      await expect(harness.connect(alice).boundedRandomUint16(100, 99)).to.be.revertedWithCustomError(
        harness,
        "BoundedRandom_InvalidRange",
      );
    });

    it("returns values within the requested range", async function () {
      const min = 1_000;
      const max = 1_127;

      for (let i = 0; i < 6; i += 1) {
        const value = await generateAndDecrypt(
          () => harness.connect(alice).boundedRandomUint16(min, max),
          () => harness.connect(alice).getLastUint16(),
          FhevmType.euint16,
        );

        expect(value).to.be.gte(BigInt(min));
        expect(value).to.be.lte(BigInt(max));
      }
    });
  });

  describe("boundedRandomUint32", function () {
    it("reverts when min is greater than max", async function () {
      await expect(harness.connect(alice).boundedRandomUint32(1_000_001, 1_000_000)).to.be.revertedWithCustomError(
        harness,
        "BoundedRandom_InvalidRange",
      );
    });

    it("returns values within the requested range", async function () {
      const min = 1_000_000;
      const max = 1_000_255;

      for (let i = 0; i < 6; i += 1) {
        const value = await generateAndDecrypt(
          () => harness.connect(alice).boundedRandomUint32(min, max),
          () => harness.connect(alice).getLastUint32(),
          FhevmType.euint32,
        );

        expect(value).to.be.gte(BigInt(min));
        expect(value).to.be.lte(BigInt(max));
      }
    });
  });

  describe("boundedRandomUint64", function () {
    it("reverts when min is greater than max", async function () {
      await expect(harness.connect(alice).boundedRandomUint64(2n, 1n)).to.be.revertedWithCustomError(
        harness,
        "BoundedRandom_InvalidRange",
      );
    });

    it("returns values within the requested range", async function () {
      const min = 1n << 60n;
      const max = min + 63n;

      for (let i = 0; i < 6; i += 1) {
        const value = await generateAndDecrypt(
          () => harness.connect(alice).boundedRandomUint64(min, max),
          () => harness.connect(alice).getLastUint64(),
          FhevmType.euint64,
        );

        expect(value).to.be.gte(min);
        expect(value).to.be.lte(max);
      }
    });
  });

  describe("boundedRandomUint128", function () {
    it("reverts when min is greater than max", async function () {
      await expect(harness.connect(alice).boundedRandomUint128(10n, 9n)).to.be.revertedWithCustomError(
        harness,
        "BoundedRandom_InvalidRange",
      );
    });

    it("returns values within the requested range", async function () {
      const min = 1n << 100n;
      const max = min + 255n;

      for (let i = 0; i < 6; i += 1) {
        const value = await generateAndDecrypt(
          () => harness.connect(alice).boundedRandomUint128(min, max),
          () => harness.connect(alice).getLastUint128(),
          FhevmType.euint128,
        );

        expect(value).to.be.gte(min);
        expect(value).to.be.lte(max);
      }
    });
  });
});
