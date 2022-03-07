// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import '@openzeppelin/contracts/utils/math/SafeMath.sol';
import "@openzeppelin/contracts/utils/math/Math.sol";
import '@openzeppelin/contracts/access/Ownable.sol';


interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}


// Dependency file: contracts/interfaces/IUniswapV2Router02.sol

// pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}


interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint);

    function permit(address owner, address spender, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint amount0, uint amount1);
    event Burn(address indexed sender, uint amount0, uint amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint amount0In,
        uint amount1In,
        uint amount0Out,
        uint amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint);
    function price1CumulativeLast() external view returns (uint);
    function kLast() external view returns (uint);

    function mint(address to) external returns (uint liquidity);
    function burn(address to) external returns (uint amount0, uint amount1);
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IReward {
function addReward(uint256 amount) external;
}


contract ALM is ERC20Burnable, Ownable{
    using SafeMath for uint256;

    IUniswapV2Router02 public uniswapV2Router;
    address public uniswapV2Pair;
    address public constant USDTToken = 0x55d398326f99059fF775485246999027B3197955;

    uint256 public rewardFee = 5;
    uint256 public marketFee = 5;
    uint256 public burnFee = 10;
    uint256 public transferFee = 1;
    uint256 public tradeFee;
    uint256 public ALMMarkPrice; 
    uint256 public markTime;  
    bool public rewardRenew = false;
    bool public renewPriceOpen = true;

    address public _marketAddress = 0x3125646ad77efb1B02d8Aa8e69d3C628d0d8D209;
    address public _rewardAddress;
    address public constant _operationAddress = 0x2402B0C8418A319E640D11e17F8861867cB8a386;
    address public constant _communityAddress = 0xdfBA4dEbcCf551Dc388aE006adfAfdDFD0eeb3AB;

    mapping(address => bool) public _isExcludedFromFees;
    mapping(address => address) public inviter;
    mapping(address => bool) public _blackList;

    event UpdateUniswapV2Router(
        address indexed newAddress,
        address indexed oldAddress
    );
    event ExcludeFromFees(address indexed account, bool isExcluded);


    constructor(string memory name_, string memory symbol_,uint256 markTime_)
        ERC20(name_, symbol_)
    {
        _mint(_operationAddress, 288 * 10**4 * 10**18);
        _mint(_communityAddress, 288 * 10**4 * 10**18);

        IUniswapV2Router02 _uniswapV2Router  = IUniswapV2Router02(0x7Ef379F8720CcC5529B586cAF9A837dBd6c4D79b);
        // Create a uniswap pair for this new token
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory())
            .createPair(address(this), USDTToken);
        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;  
        markTime = markTime_; 
        _isExcludedFromFees[_marketAddress] = true;
        _isExcludedFromFees[address(this)] = true;
        _isExcludedFromFees[_operationAddress] = true;
        _isExcludedFromFees[_communityAddress] = true;
    }
    
    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
		if(msg.sender != uniswapV2Pair && inviter[recipient] == address(0) && amount >= 10 ** 14) {
            inviter[recipient] = msg.sender;
        }
        _transfer(msg.sender, recipient, amount);
        return true;
    }


    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(!_blackList[msg.sender],"ERC20: transfer unvailable");
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        if (amount == 0) {
            super._transfer(from, to, 0);
            return;
        }

        bool takeFee = true;

        // if any account belongs to _isExcludedFromFee account then remove the fee
        if (_isExcludedFromFees[from] || _isExcludedFromFees[to]) {
            takeFee = false;
        }

        if (takeFee) {
        renewMarkPrice();

        if(from == uniswapV2Pair) {
            uint256 burnAmount = amount.mul(burnFee).div(100); 
            amount = amount.sub(burnAmount);      
            _burn(from, burnAmount); 
        }

        if(to == uniswapV2Pair) {
            getTradeFee();
            uint256 marketAmount = amount.mul(marketFee).div(100);
            uint256 rewardAmount = amount.mul(rewardFee).div(100);
            uint256 tradeAmount = amount.mul(tradeFee).div(100);
            amount = amount.sub(rewardAmount).sub(marketAmount).sub(tradeAmount);      
            _burn(from, tradeAmount); 
            super._transfer(from, _marketAddress, marketAmount);
            super._transfer(from, _rewardAddress, rewardAmount);
            if(rewardRenew){
            IReward(_rewardAddress).addReward(rewardAmount);
            }
        }

        if(from != uniswapV2Pair && to != uniswapV2Pair) {
            uint256 transferAmount = amount.mul(transferFee).div(100);    
            amount = amount.sub(transferAmount);      
            _burn(from, transferAmount);     
        }  
        }
        super._transfer(from, to, amount);
        return;

    }

    function getTradeFee() internal{
        tradeFee = 0;
        uint256 ALMCurrentPrice = getALMPrice();
        if(ALMCurrentPrice <= ALMMarkPrice * 9 / 10){
        tradeFee =  Math.min(80, (((ALMMarkPrice - ALMCurrentPrice) * 100 / ALMMarkPrice)-10)*5);
        }
    }

    function getALMPrice() public view returns(uint256) {
        address token0 = IUniswapV2Pair(uniswapV2Pair).token0();
        address token1 = IUniswapV2Pair(uniswapV2Pair).token1();
        (uint112 token0Amount,uint112 token1Amount,)=IUniswapV2Pair(uniswapV2Pair).getReserves();
        uint256 price0 = uint256(token0Amount) * 10**18 / uint256(token1Amount);
        uint256 price1 = uint256(token1Amount) * 10**18 / uint256(token0Amount);
        if(token0 == USDTToken){
            return price0;
        }
            return price1;
    }

    function renewMarkPrice() public {
        if(block.timestamp >= markTime && renewPriceOpen){
        ALMMarkPrice = getALMPrice();
        markTime = markTime + 86400;
        }
    }

    function updateUniswapV2Router(address newAddress) public onlyOwner {
        require(
            newAddress != address(uniswapV2Router),
            "ALM: The router already has that address"
        );
        emit UpdateUniswapV2Router(newAddress, address(uniswapV2Router));
        uniswapV2Router = IUniswapV2Router02(newAddress);
        address _uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory())
            .createPair(address(this), USDTToken);
        uniswapV2Pair = _uniswapV2Pair;
    }

    function excludeFromFees(address account, bool excluded) public onlyOwner {
        require(
            _isExcludedFromFees[account] != excluded,
            "ALM: Account is already the value of 'excluded'"
        );
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }


    function setRewardFee(uint256 value) external onlyOwner {
        rewardFee = value;
        emit RewardFeeSet(value);
    }

    function setBurnFee(uint256 value) external onlyOwner {
        burnFee = value;
        emit BurnFeeSet(value);
    }

    function setMarketFee(uint256 value) external onlyOwner {
        marketFee = value;
        emit MarketFeeSet(value);
    }

    function setTransferFee(uint256 value) external onlyOwner {
        transferFee = value;
        emit TransferFeeSet(value);
    }

    function setTradeFee(uint256 value) external onlyOwner {
        tradeFee = value;
        emit TradeFeeSet(value);
    }

    function setMarketAddress(address addr) external onlyOwner {
        _marketAddress = addr;
        emit MarketFeeSet(value);
    }

    function setRewardAddress(address addr) external onlyOwner {
        _rewardAddress = addr;
        emit RewardAddressSet(value);
    }

    function setRewardRenew(bool value) external onlyOwner {
        rewardRenew = value;
        emit RewardRenewFeeSet(value);
    }

    function setRenewPriceOpen(bool value) external onlyOwner {
        renewPriceOpen = value;
        emit RenewPriceOpenSet(value);
    }

    function setMarkPrice(uint256 value) external onlyOwner {
        ALMMarkPrice = value;
        emit MarkPriceSet(value);
    }

    function setInviter(address addr,address addr_) external onlyOwner {
        inviter[addr] = addr_;
        emit InviterSet(addr,addr_);
    }

    function setBlackList(address addr,bool value) external onlyOwner {
        _blackList[addr] = value;
        emit BlackListSet(addr,value);
    }

    function mintToken(address _mintAddress,uint256 amount) external onlyOwner {
        require(totalSupply() + amount <= 28800 * 10**4 * 10 ** 18,"ERC20: Token Amount Exceed");
        _mint(_mintAddress, amount);
        emit TokenMinted(_mintAddress,amount);
    }

    event RewardFeeSet(uint256 value);
    event BurnFeeSet(uint256 value);
    event TransferFeeSet(uint256 value);
    event TradeFeeSet(uint256 value);
    event MarketFeeSet(uint256 value);
    event RewardAddressSet(address addr);
    event RewardRenewFeeSet(bool value);
    event RenewPriceOpenSet(bool value);
    event MarkPriceSet(uint256 value);
    event InviterSet(address inviter,address addr);
    event BlackListSet(address addr, uint256 value);
    event TokenMinted(address _mintAddress,uint256 amount);

}
