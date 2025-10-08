import { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers, fhevm } from "hardhat";
import { FhevmType, FhevmTypeEuint } from "@fhevm/hardhat-plugin";
import type { ContractTransactionResponse } from "ethers";

import { LibSortHarness, LibSortHarness__factory } from "../types";

describe("LibSort", function () {
  let alice: HardhatEthersSigner;
  let harness: LibSortHarness;
  let harnessAddress: string;

  before(async function () {
    [, alice] = await ethers.getSigners();
  });

  beforeEach(async function () {
    if (!fhevm.isMock) {
      this.skip();
    }

    const factory = (await ethers.getContractFactory("LibSortHarness")) as LibSortHarness__factory;
    harness = (await factory.deploy()) as LibSortHarness;
    harnessAddress = await harness.getAddress();
  });

  const executeAndDecrypt = async (
    action: () => Promise<ContractTransactionResponse>,
    getterLower: () => Promise<string>,
    getterUpper: () => Promise<string>,
    fhevmType: FhevmType,
  ): Promise<{ lower: bigint; upper: bigint }> => {
    const tx = await action();
    await tx.wait();

    const [lowerHandle, upperHandle] = await Promise.all([getterLower(), getterUpper()]);
    const lower = await fhevm.userDecryptEuint(fhevmType as FhevmTypeEuint, lowerHandle, harnessAddress, alice);
    const upper = await fhevm.userDecryptEuint(fhevmType as FhevmTypeEuint, upperHandle, harnessAddress, alice);

    return { lower, upper };
  };

  const decryptArray = async (
    getLength: () => Promise<bigint>,
    getAt: (index: number) => Promise<string>,
    fhevmType: FhevmType,
  ): Promise<bigint[]> => {
    const length = Number(await getLength());
    const values: bigint[] = [];
    for (let i = 0; i < length; i += 1) {
      const handle = await getAt(i);
      const value = await fhevm.userDecryptEuint(fhevmType as FhevmTypeEuint, handle, harnessAddress, alice);
      values.push(value);
    }
    return values;
  };

  it("orders uint8 values", async function () {
    const result = await executeAndDecrypt(
      () => harness.connect(alice).orderUint8(11, 3),
      () => harness.connect(alice).getLastUint8Lower(),
      () => harness.connect(alice).getLastUint8Upper(),
      FhevmType.euint8,
    );

    expect(result.lower).to.eq(3n);
    expect(result.upper).to.eq(11n);

    const alreadySorted = await executeAndDecrypt(
      () => harness.connect(alice).orderUint8(7, 7),
      () => harness.connect(alice).getLastUint8Lower(),
      () => harness.connect(alice).getLastUint8Upper(),
      FhevmType.euint8,
    );

    expect(alreadySorted.lower).to.eq(7n);
    expect(alreadySorted.upper).to.eq(7n);
  });

  it("orders uint16 values", async function () {
    const result = await executeAndDecrypt(
      () => harness.connect(alice).orderUint16(5000, 1234),
      () => harness.connect(alice).getLastUint16Lower(),
      () => harness.connect(alice).getLastUint16Upper(),
      FhevmType.euint16,
    );

    expect(result.lower).to.eq(1234n);
    expect(result.upper).to.eq(5000n);
  });

  it("orders uint32 values", async function () {
    const result = await executeAndDecrypt(
      () => harness.connect(alice).orderUint32(2_000_000, 10_000),
      () => harness.connect(alice).getLastUint32Lower(),
      () => harness.connect(alice).getLastUint32Upper(),
      FhevmType.euint32,
    );

    expect(result.lower).to.eq(10_000n);
    expect(result.upper).to.eq(2_000_000n);
  });

  it("orders uint64 values", async function () {
    const large = (1n << 60n) + 42n;
    const small = 99n;

    const result = await executeAndDecrypt(
      () => harness.connect(alice).orderUint64(large, small),
      () => harness.connect(alice).getLastUint64Lower(),
      () => harness.connect(alice).getLastUint64Upper(),
      FhevmType.euint64,
    );

    expect(result.lower).to.eq(small);
    expect(result.upper).to.eq(large);
  });

  it("orders uint128 values", async function () {
    const high = (1n << 100n) + 5n;
    const low = (1n << 64n) + 1n;

    const result = await executeAndDecrypt(
      () => harness.connect(alice).orderUint128(high, low),
      () => harness.connect(alice).getLastUint128Lower(),
      () => harness.connect(alice).getLastUint128Upper(),
      FhevmType.euint128,
    );

    expect(result.lower).to.eq(low);
    expect(result.upper).to.eq(high);
  });

  describe("bubbleSort", function () {
    it("sorts uint8 arrays", async function () {
      const tx = await harness.connect(alice).bubbleSortUint8([5, 1, 3, 3]);
      await tx.wait();
      const sorted = await decryptArray(
        () => harness.connect(alice).getSortedUint8Length(),
        (index) => harness.connect(alice).getSortedUint8At(index),
        FhevmType.euint8,
      );
      expect(sorted).to.deep.equal([1n, 3n, 3n, 5n]);
    });

    it("sorts uint16 arrays", async function () {
      const tx = await harness.connect(alice).bubbleSortUint16([6000, 42, 4096]);
      await tx.wait();
      const sorted = await decryptArray(
        () => harness.connect(alice).getSortedUint16Length(),
        (index) => harness.connect(alice).getSortedUint16At(index),
        FhevmType.euint16,
      );
      expect(sorted).to.deep.equal([42n, 4096n, 6000n]);
    });

    it("sorts uint32 arrays", async function () {
      const tx = await harness.connect(alice).bubbleSortUint32([10_000_000, 5, 7_000]);
      await tx.wait();
      const sorted = await decryptArray(
        () => harness.connect(alice).getSortedUint32Length(),
        (index) => harness.connect(alice).getSortedUint32At(index),
        FhevmType.euint32,
      );
      expect(sorted).to.deep.equal([5n, 7_000n, 10_000_000n]);
    });

    it("sorts uint64 arrays", async function () {
      const tx = await harness.connect(alice).bubbleSortUint64([1n << 50n, 123n, (1n << 40n) + 1n]);
      await tx.wait();
      const sorted = await decryptArray(
        () => harness.connect(alice).getSortedUint64Length(),
        (index) => harness.connect(alice).getSortedUint64At(index),
        FhevmType.euint64,
      );
      expect(sorted).to.deep.equal([123n, (1n << 40n) + 1n, 1n << 50n]);
    });

    it("sorts uint128 arrays", async function () {
      const tx = await harness.connect(alice).bubbleSortUint128([(1n << 120n) + 7n, 99n, 1n << 60n]);
      await tx.wait();
      const sorted = await decryptArray(
        () => harness.connect(alice).getSortedUint128Length(),
        (index) => harness.connect(alice).getSortedUint128At(index),
        FhevmType.euint128,
      );
      expect(sorted).to.deep.equal([99n, 1n << 60n, (1n << 120n) + 7n]);
    });

    it("handles single-element arrays", async function () {
      const tx8 = await harness.connect(alice).bubbleSortUint8([55]);
      await tx8.wait();
      const single8 = await decryptArray(
        () => harness.connect(alice).getSortedUint8Length(),
        (index) => harness.connect(alice).getSortedUint8At(index),
        FhevmType.euint8,
      );
      expect(single8).to.deep.equal([55n]);

      const tx32 = await harness.connect(alice).bubbleSortUint32([123_456]);
      await tx32.wait();
      const single32 = await decryptArray(
        () => harness.connect(alice).getSortedUint32Length(),
        (index) => harness.connect(alice).getSortedUint32At(index),
        FhevmType.euint32,
      );
      expect(single32).to.deep.equal([123_456n]);
    });

    it("handles empty arrays", async function () {
      const tx = await harness.connect(alice).bubbleSortUint8([]);
      await tx.wait();
      const empty = await decryptArray(
        () => harness.connect(alice).getSortedUint8Length(),
        (index) => harness.connect(alice).getSortedUint8At(index),
        FhevmType.euint8,
      );
      expect(empty).to.deep.equal([]);
    });
  });
});
