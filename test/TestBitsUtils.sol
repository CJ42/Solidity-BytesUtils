// SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "truffle/Assert.sol";
import "../contracts/BitsUtils.sol";

contract TestBitsUtils {
    using BitsUtils for *;

    function testOddNumberAsm() public {
        uint number = 3;
        bool expected = true;

        Assert.equal(number.isOdd(true), expected, "Should have returned true");
    }

    function testInvalidOddNumberAsm() public {
        uint number = 4;
        bool expected = false;

        Assert.equal(number.isOdd(true), expected, "Should have returned false");
    }

    function testSecondBitSetAsm() public {
        uint number = 6;
        uint nthBit = 2;

        Assert.equal(number.isNthBitSet(nthBit, true), true, "Should have returned true, as the 2nd bit is set (value '6' in binary = 110)");
    }

    function testThirdBitSetAsm() public {
        uint number = 13;
        uint nthBit = 3;

        Assert.equal(number.isNthBitSet(nthBit, true), true, "Should have returned true, as the 3rd bit is set (value '13' in binary = 1101)");
    }

    function testThirdBitSetAsm2() public {
        uint number = 122; // 0111 1010
        uint nthBit = 3; //        ^

        Assert.equal(number.isNthBitSet(nthBit, true), false, "Should have returned false, as the 2nd bit is not set (value '13' in binary = 1101)");
    }
}