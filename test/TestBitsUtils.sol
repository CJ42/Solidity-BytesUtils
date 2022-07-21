// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "truffle/Assert.sol";
import "../contracts/BitsUtils.sol";

contract TestBitsUtils {
    using BitsUtils for *;

    function testOddNumber() public {
        uint number = 3;
        bool expected = true;

        Assert.equal(number.isOdd(), expected, "Should have returned true");
    }

    function testOddNumberAsm() public {
        uint number = 3;
        bool expected = true;

        Assert.equal(number.isOddAsm(), expected, "Should have returned true");
    }

    function testInvalidOddNumber() public {
        uint number = 4;
        bool expected = false;

        Assert.equal(number.isOdd(), expected, "Should have returned false");
    }

    function testInvalidOddNumberAsm() public {
        uint number = 4;
        bool expected = false;

        Assert.equal(number.isOddAsm(), expected, "Should have returned false");
    }

    function testSecondBitSet() public {
        uint number = 6;
        uint nthBit = 2;

        Assert.equal(number.isNthBitSet(nthBit), true, "Should have returned true, as the 2nd bit is set (value '6' in binary = 110)");
    }

    function testSecondBitSetAsm() public {
        uint number = 6;
        uint nthBit = 2;

        Assert.equal(number.isNthBitSetAsm(nthBit), true, "Should have returned true, as the 2nd bit is set (value '6' in binary = 110)");
    }

    function testThirdBitSet() public {
        uint number = 13; // 1101
        uint nthBit = 3; //   ^

        Assert.equal(number.isNthBitSet(nthBit), true, "Should have returned true, as the 3rd bit is set (value '13' in binary = 1101)");
    }

    function testThirdBitSetAsm() public {
        uint number = 13; // 1101
        uint nthBit = 3; //   ^

        Assert.equal(number.isNthBitSetAsm(nthBit), true, "Should have returned true, as the 3rd bit is set (value '13' in binary = 1101)");
    }

    function testThirdBitNotSetAsm() public {
        uint number = 122; // 0111 1010
        uint nthBit = 3; //         ^

        Assert.equal(number.isNthBitSetAsm(nthBit), false, "Should have returned false, as the 3rd bit is not set (value '122' in binary = 0111 1010)");
    }
}