// SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

/// @title Library to manipulate bits on unsigned integers
/// @author Jean Cavallera (CJ42)
/// @dev most functions are implemented with a low-level Assembly mode for gas optimisation
library BitsUtils {
    
    function isOdd(uint x, bool assemblyMode) public pure returns (bool) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, and(x, 1))
                return(0x00, 32)
            }
        } else {
            return (x & 1) == 1;
        }
    }

    function isOdd(int x, bool assemblyMode) public pure returns (bool) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, and(x, 1))
                return(0x00, 32)
            }
        } else {
            return (x & 1) == 1;
        }
    }
    

    /// #2.1 Test if the n-th bit is set.
    function isNthBitSet(uint x, uint n, bool assemblyMode) public pure returns (bool) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, and(x, shl(1, n)))
                return(0x00, 32)
            }
        } else {
            // if the nth bit is set:
            //    -> anding will eliminate all the bits EXCEPT the nth bit (so will return a number)
            // else:
            //    -> anding will eliminate ALL the bits (so will return 0)
            return x & (1 << n) != 0 ? true : false;
        }
    }
    
    // TODO: isNthBitSet for signed integers
    
    /// #3 Set the n-th bit.
    function setNthBit(uint x, uint n, bool assemblyMode) public pure returns (uint) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, or(x, shl(n, 1)))
                return(0x00, 32)
            }
        } else {
            return x | (1 << n);
        }
    }
    
    
    // TODO: setNthBitSet for signed integers
    
    /// #4 Unset the n-th bit.
    function unsetNthBit(uint x, uint n, bool assemblyMode) public pure returns (uint) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, and(x, not(shl(n, 1))))
                return(0x00, 32)
            }
        } else {
            return x & ~(1 << n);
        }
    }
    
    /// #5 Toggle the n-th bit
    function toggleNthBit(uint x, uint n, bool assemblyMode) public pure returns (uint) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, xor(x, shl(n, 1)))
                return(0x00, 32)
            }
        } else {
            return x ^ (1 << n);
        }
        
    
        
    }
    
    /// #6 Turn off the rightmost 1-bit
    function toggleRightmost1Bit(uint x, bool assemblyMode) public pure returns (uint) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, and(x, sub(x, 1)))
                return(0x00, 32)
            }
        } else {
            return x & (x - 1);
        }
        
    }
    
    
    /// #7. Isolate the rightmost 1-bit.
    // function isolateRightmostBit(uint x) public pure returns (uint) {
        
    // }
    
    
    
    /// #8. Right propagate the rightmost 1-bit.
    // TODO: this does not always return the expected result. Need more deep dive
    // NOTE: Beaware for 'x' = 0, all the bits will be turned to 1.
    // it will then overflow and return the biggest uint possible (2²⁵⁶-1)
    function rightPropagateRightmost1Bit(uint x, bool assemblyMode) public pure returns (uint) {
        if (assemblyMode) {
            assembly {
                mstore(0x00, or(x, sub(x, 1)))
                return(0x00, 32)
            }
        } else {
            return x | (x - 1);
        }
    }
    
    // TODO: rightPropagateRightmostBit for signed integers
    
    
    /// #9. Isolate the rightmost 0-bit.
    // TODO: assembly mode
    function isolateRightmost0Bit(uint x) public pure returns (uint) {
        return ~x & (x + 1);
    }
    
    
    /// #10. Turn on the rightmost 0-bit.
    // TODO: assembly mode
    function turnOnRightmost0Bit(uint x) public pure returns (uint) {
        return x | (x + 1);
    }

}