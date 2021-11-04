pragma solidity >=0.4.22 <0.9.0;

contract OrderMaker {
  struct Order {
    string itemName;
    uint price;
    uint quantity;
  }

  Order[] private orders;

  constructor() public {
    _createOrder('Jalapenos', 12, 5);
  }

  mapping(address => Order) public ordersByUser;
  mapping(uint => Order) public ordersById;

  function _createOrder(
    string memory _itemName,
    uint _quantity,
    uint _price
  ) internal {
    orders.push(Order(_itemName, _quantity, _price));

    uint id = orders.length;

    ordersByUser[msg.sender] = orders[id - 1];
    ordersById[id] = orders[id - 1];
  }

  function createOrder(string memory _itemName, uint _quantity) public payable {
    require(msg.value == 0.001 ether);

    uint itemPrice = _lookupPrice(_itemName);

    _createOrder(_itemName, _quantity, itemPrice);
  }

  function _lookupPrice(string memory _itemName)
    private
    pure
    returns (uint256 price)
  {
    if (
      keccak256(abi.encodePacked(_itemName)) ==
      keccak256(abi.encodePacked('Jalapeno'))
    ) {
      return 9;
    } else if (
      keccak256(abi.encodePacked(_itemName)) ==
      keccak256(abi.encodePacked('Feta'))
    ) {
      return 12;
    } else if (
      keccak256(abi.encodePacked(_itemName)) ==
      keccak256(abi.encodePacked('Water'))
    ) {
      return 18;
    } else if (
      keccak256(abi.encodePacked(_itemName)) ==
      keccak256(abi.encodePacked('Lemon'))
    ) {
      return 15;
    } else {
      return 5;
    }
  }
}
