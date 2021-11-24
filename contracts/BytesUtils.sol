// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/// @title Library to manipulate bytes Solidity Contracts
/// @author Jean Cavallera (CJ42)
/// @dev most functions use low-level Assembly
library BytesUtils {

    function getFirstHalfBytes(bytes32 _data) public pure returns (bytes16) {
        return bytes16(_data);
    }
    
    function getLastHalfBytes(bytes32 _data) public pure returns (bytes16) {
        bytes32 lastHalf = _data << uint256(8 * 16);
        return bytes16(lastHalf);
    }

    // test data: 0xcafecafe4d1a35a74cb8def4342a0b7edf1a39083c98f47dd22d0560844b2045
    // returns:   0xcafecafe
    function getFirst4Bytes(bytes32 _data) public pure returns (bytes4) {
        return bytes4(_data);
    }

    function getLast4Bytes(bytes32 _data) public pure returns (bytes4) {
        bytes32 end = _data << uint256(8 * 28);
        return bytes4(end);
    }

    // TODO: 
    //  - first n bytes
    //  - last n bytes

    // 
    //      We want to keep this part | discard this part
    //                             |     |
    //                             V     V
    //                            1011 0101

    //          decimal | hex  | binary
    //          ------- | ---- | ---------
    // value:     181   | 0xb5 | 1011 0101  
    // mask:      248   | 0xf8 | 1111 1000
    //          --------------------------
    // result:    176   | 0xb0 | 1011 0000
    // 
    function andingWithMask(bytes1 _value, bytes1 _mask) public pure returns(bytes1) {
        return _value & _mask;
    }

    // Not working (WIP)
    // --------------------------------------------------------
    
    // value: 0xcafecafecafecafecafecafecafecafe12345678901234567890123456789012
    //  mask: 0x3FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE00000000000000000000000000000000
    // should return: just the 'cafe' part
    // not working yet
    // function getFirstHalfBytesTest(bytes32 _value) public pure returns(bytes16) {
    //     bytes16 nOnes = bytes16(uint128(2 ** 16 - 1));
    //     bytes16 _mask = nOnes >> (8 - 16);
    //     bytes32 result = _value & _mask;
    //     return bytes16(result);
    // }

    // not working yet
    function getLastHalfBytesTest(
        bytes32 _value
    ) public pure returns (bytes16) {
        uint lastN = uint(_value) % (2 ** 128);
        return bytes16(uint128(lastN));
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
    
    // not working
    function getFirstNBytes(
        bytes1 _x,
        uint8 _n
    ) public pure returns (bytes1) {
        require(2 ** _n < 255, "Overflow encountered ! ");
        bytes1 nOnes = bytes1(uint8(2) ** _n - 1);
        bytes1 mask = nOnes >> (8 - _n); // Total 8 bits
        return _x & mask;
    }

    function toBinaryString(uint256 _input) internal pure returns (string memory) {
        bytes memory output = new bytes(32);

        for (uint256 ii = 0; ii < 32; ii++) {
            output[32 - i] = (_input % 2 == 1) ? byte("1") : byte("0");
            input /= 2;
        }

        return string(output);
    }

    function toBinaryString(bytes memory _input) internal pure returns (string memory) {
        uint256 length = _input.length;

        bytes memory output = new bytes(length);

        for (uint256 ii = 0; ii < length; ii++) {
            output[length - ii] = (_input % 2 == 1) ? byte("1") : byte("0");
            input /= 2;
        }

        return string(output);
    }
    
}