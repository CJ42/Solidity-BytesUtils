// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/// @title Library to manipulate bits on unsigned integers
/// @author Jean Cavallera (CJ42)
/// @dev most functions are implemented with a low-level Assembly mode for gas optimisation
library BitsUtils {
    
    /// @dev check if an unsigned integer is odd or even
    /// @param input the number to check
    function isOdd(uint256 input) internal pure returns (bool) {
        return (input & 1) == 1;
    }
    

    /// @dev check if the nth bit is set in a 256 bits unsigned integer
    /// @param input the number to check
    /// @param nthBit the bit number to check in the binary representation of the number
    function isNthBitSet(uint256 input, uint256 nthBit) internal pure returns (bool) {
        // if the nth bit is set:
        //    -> anding will eliminate all the bits EXCEPT the nth bit (so will return a number)
        // else:
        //    -> anding will eliminate ALL the bits (so will return 0)
        return input & (1 << nthBit) != 0 ? true : false;
    }
    
    /// @dev set the `nthBit` to 1 if it was set to 0
    /// @param input a uint256 number
    /// @param nthBit the bit number to set in `input`, counting from the right
    function setNthBit(uint256 input, uint256 nthBit) internal pure returns (uint256) {
        return input | (1 << nthBit);
    }
    
    function unsetNthBit(uint256 input, uint256 nthBit) internal pure returns (uint256) {
        return input & ~(1 << nthBit);
    }
    
    function toggleNthBit(uint256 input, uint256 nthBit) internal pure returns (uint256) {
        return input ^ (1 << nthBit);
    }
    
    function toggleRightmost1Bit(uint256 input) internal pure returns (uint256) {
        return input & (input - 1);        
    }
    
    
    /// @dev this does not always return the expected result. Need more deep dive
    ///     Beaware if 'input' = 0, all the bits will be turned to 1.
    /// it will then overflow and return the biggest uint256 possible (2 ** 256 -1)
    function rightPropagateRightmost1Bit(uint256 input) internal pure returns (uint256) {
        return input | (input - 1);
    }
    
    function isolateRightmost0Bit(uint256 input) internal pure returns (uint256) {
        return ~input & (input + 1);
    }
    
    function isolateRightmost1Bit(uint256 input) internal pure returns (uint256) {
        // y = x & (-x)
        return input & uint256(-int256(input));
    }
    
    function turnOnRightmost0Bit(uint256 input) internal pure returns (uint256) {
        return input | (input + 1);
    }

    // Optimised version of the functions, using assembly and YUL
    // use this caution

    function isOddAsm(uint256 input) internal pure returns (bool) {
        assembly {
            mstore(0x00, and(input, 1))
            return(0x00, 32)
        }
    }

    function isNthBitSetAsm(uint256 input, uint256 nthBit) internal pure returns (bool) {
        // if the nth bit is set:
        //    -> anding will eliminate all the bits EXCEPT the nth bit (so will return a number)
        // else:
        //    -> anding will eliminate ALL the bits (so will return 0)
        assembly {
            mstore(0x00, and(input, shl(1, nthBit)))
            return(0x00, 32)
        }   
    }

    function setNthBitAsm(uint256 input, uint256 nthBit) internal pure returns (uint256) {
        assembly {
            mstore(0x00, or(input, shl(nthBit, 1)))
            return(0x00, 32)
        }
    }

    function unsetNthBitAsm(uint256 input, uint256 nthBit) internal pure returns (uint256) {
        assembly {
            mstore(0x00, and(input, not(shl(nthBit, 1))))
            return(0x00, 32)
        }
    }

    function toggleNthBitAsm(uint256 input, uint256 nthBit) internal pure returns (uint256) {
        assembly {
            mstore(0x00, xor(input, shl(nthBit, 1)))
            return(0x00, 32)
        }        
    }

    function toggleRightmost1BitAsm(uint256 input) internal pure returns (uint256) {
        assembly {
            mstore(0x00, and(input, sub(input, 1)))
            return(0x00, 32)
        }
    }
}
