pragma solidity ^0.8.0;

/// @title A Bytes Utility Library for Solidity Contracts
/// @author Jean Cavallera (CJ42)
/// @dev most functions use low-level Assembly
library BytesUtils {

    /// #1 check if number is Odd
    function isOdd(uint x) public pure returns (bool) {
        assembly {
            mstore(0x00, and(x, 1))
            return(0x00, 32)
        }
    }

    /// #2.1 Test if the n-th bit is set.
    /// for unsigned integers
    function isNthBitSet(uint x, uint n) public pure returns (bool) {
        assembly {
            mstore(0x00, and(x, shl(1, n)))
            return(0x00, 32)
        }
    }
    
    /// #2.2 Test if the n-th bit is set.
    /// for signed integers (function overloading)
    /*function isNthBitSet(int x, uint n) public pure returns (bool) {
        assembly {
            mstore(0x00, and(x, shl(1, n)))
            return(0x00, 32)
        }
    }*/
    
    /// #3 Set the n-th bit.
    function setNthBit(uint x, uint n) public pure returns (uint) {
        assembly {
            mstore(0x00, or(x, shl(1, n)))
            return(0x00, 32)
        }
    }
    
    /// #4 Unset the n-th bit.
    // not expected result
    function unsetNthBit(uint x, uint n) public pure returns (uint) {
        assembly {
            mstore(0x00, and(x, not(shl(1, n))))
            return(0x00, 32)
        }
    }
    
    /// #5 Toggle the n-th bit.
    // not expected result
    function toggleNthBit(uint x, uint n) public pure returns (uint) {
        assembly {
            mstore(0x00, xor(x, shl(1, n)))
            return(0x00, 32)
        }
    }
    
    
    
    /// #6 Turn off the rightmost 1-bit
    
    
    
    
    /// #7. Isolate the rightmost 1-bit.
    
    
    
    
    /// #8. Right propagate the rightmost 1-bit.
    
    
    
    
    /// #9. Isolate the rightmost 0-bit.
    
    
    
    
    /// #10. Turn on the rightmost 0-bit.
    
    // Try with the following:
    // value: 0xcafecafecafecafecafecafecafecafe12345678901234567890123456789012
    //  mask: 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE00000000000000000000000000000000
    // should return: just the 'cafe' part
    // not working yet
    function getFirstHalfBytes(bytes32 _value) public pure returns(bytes16) {
        bytes16 nOnes = bytes16(uint128(2 ** 16 - 1));
        bytes16 _mask = nOnes >> (8 - 16);
        bytes32 result = _value & _mask;
        return bytes16(result);
    }

    // 0xeafec4d89fa9619884b6b89135626455000000000000000000000000afdeb5d6
    // 0x2afec4d89fa9619884b6b89135626454
    function getLastHalfBytes(
        bytes32 _value
    ) public pure returns (bytes16) {
        uint lastN = uint(_value) % (2 ** 128);
        return bytes16(uint128(lastN));
    }

    // Testing ---------- 

    // testing data
    // 0xcafecafe52D386f254917e481eB44e9943F39138
    // 0xcafecafe4d1a35a74cb8def4342a0b7edf1a39083c98f47dd22d0560844b2045

    function test(bytes1 _value, bytes1 _mask) public pure returns(bytes1) {
        return _value & _mask;
    }


    /*
    function getFirstNBytes(
        bytes32 _x,
        uint8 _n
    ) public pure returns (bytes4) {
        
        bytes32 nOnes = bytes32(2 ** _n - 1);
        bytes32 mask = nOnes >> (256 - _n); // Total 8 bits
        return _x & mask;
    }
    */
    
    function getFirstNBytes(
        bytes1 _x,
        uint8 _n
    ) public pure returns (bytes1) {
        require(2 ** _n < 255, "Overflow encountered ! ");
        bytes1 nOnes = bytes1(uint8(2) ** _n - 1);
        bytes1 mask = nOnes >> (8 - _n); // Total 8 bits
        return _x & mask;
    }   
    
}