import { HardhatEthersSigner } from "@nomicfoundation/hardhat-ethers/signers";
import { expect } from "chai";
import { ethers, fhevm } from "hardhat";
import { FhevmType, FhevmTypeEuint } from "@fhevm/hardhat-plugin";

import { SafeCastLibHarness, SafeCastLibHarness__factory } from "../types";

describe("SafeCastLib", function () {
  let alice: HardhatEthersSigner;
  let harness: SafeCastLibHarness;
  let harnessAddress: string;

  before(async function () {
    [, alice] = await ethers.getSigners();
  });

  beforeEach(async function () {
    if (!fhevm.isMock) {
      this.skip();
    }

    const factory = (await ethers.getContractFactory("SafeCastLibHarness")) as SafeCastLibHarness__factory;
    harness = (await factory.deploy()) as SafeCastLibHarness;
    harnessAddress = await harness.getAddress();
  });

  const decrypt = async (handle: string, fhevmType: FhevmType) =>
    fhevm.userDecryptEuint(fhevmType as FhevmTypeEuint, handle, harnessAddress, alice);

  const decryptBool = async (handle: string) =>
    fhevm.userDecryptEbool(handle, harnessAddress, alice);

  it("casts to euint128 within bounds", async function () {
    const tx = await harness.connect(alice).castToEuint128((1n << 100n) + 5n);
    await tx.wait();
    const handle = await harness.connect(alice).getLastUint128();
    const overflowHandle = await harness.connect(alice).getLastUint128Overflow();
    const value = await decrypt(handle, FhevmType.euint128);
    const overflow = await decryptBool(overflowHandle);
    expect(value).to.eq((1n << 100n) + 5n);
    expect(overflow).to.eq(false);
  });

  it("flags overflow when casting to euint128", async function () {
    const tx = await harness.connect(alice).castToEuint128(1n << 128n);
    await tx.wait();
    const overflowHandle = await harness.connect(alice).getLastUint128Overflow();
    const overflow = await decryptBool(overflowHandle);
    expect(overflow).to.eq(true);
  });

  it("casts to euint64 within bounds", async function () {
    const tx = await harness.connect(alice).castToEuint64(123_456_789n);
    await tx.wait();
    const handle = await harness.connect(alice).getLastUint64();
    const overflowHandle = await harness.connect(alice).getLastUint64Overflow();
    const value = await decrypt(handle, FhevmType.euint64);
    const overflow = await decryptBool(overflowHandle);
    expect(value).to.eq(123_456_789n);
    expect(overflow).to.eq(false);
  });

  it("flags overflow when casting to euint64", async function () {
    const tx = await harness.connect(alice).castToEuint64(1n << 64n);
    await tx.wait();
    const overflowHandle = await harness.connect(alice).getLastUint64Overflow();
    const overflow = await decryptBool(overflowHandle);
    expect(overflow).to.eq(true);
  });

  it("casts to euint32 within bounds", async function () {
    const tx = await harness.connect(alice).castToEuint32(4_294_967_295n);
    await tx.wait();
    const handle = await harness.connect(alice).getLastUint32();
    const overflowHandle = await harness.connect(alice).getLastUint32Overflow();
    const value = await decrypt(handle, FhevmType.euint32);
    const overflow = await decryptBool(overflowHandle);
    expect(value).to.eq(4_294_967_295n);
    expect(overflow).to.eq(false);
  });

  it("flags overflow when casting to euint32", async function () {
    const tx = await harness.connect(alice).castToEuint32(4_294_967_296n);
    await tx.wait();
    const overflowHandle = await harness.connect(alice).getLastUint32Overflow();
    const overflow = await decryptBool(overflowHandle);
    expect(overflow).to.eq(true);
  });

  it("casts to euint16 within bounds", async function () {
    const tx = await harness.connect(alice).castToEuint16(65_535n);
    await tx.wait();
    const handle = await harness.connect(alice).getLastUint16();
    const overflowHandle = await harness.connect(alice).getLastUint16Overflow();
    const value = await decrypt(handle, FhevmType.euint16);
    const overflow = await decryptBool(overflowHandle);
    expect(value).to.eq(65_535n);
    expect(overflow).to.eq(false);
  });

  it("flags overflow when casting to euint16", async function () {
    const tx = await harness.connect(alice).castToEuint16(65_536n);
    await tx.wait();
    const overflowHandle = await harness.connect(alice).getLastUint16Overflow();
    const overflow = await decryptBool(overflowHandle);
    expect(overflow).to.eq(true);
  });

  it("casts to euint8 within bounds", async function () {
    const tx = await harness.connect(alice).castToEuint8(200n);
    await tx.wait();
    const handle = await harness.connect(alice).getLastUint8();
    const overflowHandle = await harness.connect(alice).getLastUint8Overflow();
    const value = await decrypt(handle, FhevmType.euint8);
    const overflow = await decryptBool(overflowHandle);
    expect(value).to.eq(200n);
    expect(overflow).to.eq(false);
  });

  it("flags overflow when casting to euint8", async function () {
    const tx = await harness.connect(alice).castToEuint8(256n);
    await tx.wait();
    const overflowHandle = await harness.connect(alice).getLastUint8Overflow();
    const overflow = await decryptBool(overflowHandle);
    expect(overflow).to.eq(true);
  });
});
