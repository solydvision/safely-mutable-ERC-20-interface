interface ERC20TokenImplementation {
  function totalSupply () public constant returns (uint);
  function balanceOf (address tokenOwner) public constant returns (uint balance);
  function allowance (address tokenOwner, address spender) public constant returns (uint remaining);
  function transfer (address caller, address to, uint tokens) public returns (bool success);
  function approve (address caller, address spender, uint tokens) public returns (bool success);
  function transferFrom (address caller, address from, address to, uint tokens) public returns (bool success);
  event Transfer (address indexed from, address indexed to, uint tokens);
  event Approval (address indexed tokenOwner, address indexed spender, uint tokens);

}
contract LARVA_ERC20Interface {
  modifier LARVA_DEA_3_handle_after_approve__parameters_spender_tokens (address spender, uint tokens) {
    if ((LARVA_STATE_3 == 1) && (allowance(msg.sender, spender) == tokens)) {
      LARVA_STATE_3 = 0;
    } else {
      if ((LARVA_STATE_3 == 1) && (allowance(msg.sender, spender) != tokens)) {
        LARVA_STATE_3 = 2;
        LARVA_reparation();
      } else {
      }
    }
    _;
  }
  modifier LARVA_DEA_3_handle_before_approve__parameters_spender_tokens (address spender, uint tokens) {
    if ((LARVA_STATE_3 == 0)) {
      LARVA_STATE_3 = 1;
    } else {
      if ((LARVA_STATE_3 == 1)) {
        LARVA_STATE_3 = 2;
        LARVA_reparation();
      } else {
      }
    }
    _;
  }
  modifier LARVA_DEA_2_handle_after_transferFrom__parameters_from_to_tokens (address from, address to, uint tokens) {
    if ((LARVA_STATE_2 == 1) && ((transferFromPreFrom < tokens || preAllowance < tokens) && (balanceOf(msg.sender) != transferFromPreFrom || balanceOf(to) != transferFromPreTo || allowance(msg.sender, from) != preAllowance))) {
      LARVA_STATE_2 = 2;
      LARVA_reparation();
    } else {
      if ((LARVA_STATE_2 == 1) && ((transferFromPreFrom < tokens || preAllowance < tokens) && (balanceOf(msg.sender) == transferFromPreFrom && balanceOf(to) == transferFromPreTo && allowance(msg.sender, from) == preAllowance))) {
        LARVA_STATE_2 = 0;
      } else {
        if ((LARVA_STATE_2 == 1) && ((transferFromPreFrom >= tokens && preAllowance >= tokens) && (balanceOf(msg.sender) != (transferFromPreFrom - tokens) || balanceOf(to) != (transferFromPreTo - tokens) || allowance(msg.sender, from) != preAllowance - tokens))) {
          LARVA_STATE_2 = 2;
          LARVA_reparation();
        } else {
          if ((LARVA_STATE_2 == 1) && ((transferFromPreFrom >= tokens && preAllowance >= tokens) && (balanceOf(msg.sender) == (transferFromPreFrom - tokens) && balanceOf(to) == (transferFromPreTo - tokens) && allowance(msg.sender, from) == preAllowance - tokens))) {
            LARVA_STATE_2 = 0;
          } else {
          }
        }
      }
    }
    _;
  }
  modifier LARVA_DEA_2_handle_before_transferFrom__parameters_from_to_tokens (address from, address to, uint tokens) {
    if ((LARVA_STATE_2 == 0)) {
      LARVA_STATE_2 = 1;
      {
        transferFromPreFrom = balanceOf(from);
        transferFromPreTo = balanceOf(to);
        preAllowance = allowance(msg.sender, from);
      }
    } else {
      if ((LARVA_STATE_2 == 1)) {
        LARVA_STATE_2 = 2;
        LARVA_reparation();
      } else {
      }
    }
    _;
  }
  modifier LARVA_DEA_1_handle_after_transfer__parameters_to_tokens (address to, uint tokens) {
    if ((LARVA_STATE_1 == 1) && (transferPreFrom < tokens && (balanceOf(msg.sender) != transferPreFrom || balanceOf(to) != transferPreTo))) {
      LARVA_STATE_1 = 2;
      LARVA_reparation();
    } else {
      if ((LARVA_STATE_1 == 1) && (transferPreFrom < tokens && (balanceOf(msg.sender) == transferPreFrom && balanceOf(to) == transferPreTo))) {
        LARVA_STATE_1 = 0;
      } else {
        if ((LARVA_STATE_1 == 1) && (transferPreFrom >= tokens && (balanceOf(msg.sender) != (transferPreFrom - tokens) || balanceOf(to) != (transferPreTo - tokens)))) {
          LARVA_STATE_1 = 2;
          LARVA_reparation();
        } else {
          if ((LARVA_STATE_1 == 1) && (transferPreFrom >= tokens && (balanceOf(msg.sender) == (transferPreFrom - tokens) && balanceOf(to) == (transferPreTo - tokens)))) {
            LARVA_STATE_1 = 0;
          } else {
          }
        }
      }
    }
    _;
  }
  modifier LARVA_DEA_1_handle_before_transfer__parameters_to_tokens (address to, uint tokens) {
    if ((LARVA_STATE_1 == 0)) {
      LARVA_STATE_1 = 1;
      {
        transferPreFrom = balanceOf(msg.sender);
        transferPreTo = balanceOf(to);
      }
    } else {
      if ((LARVA_STATE_1 == 1)) {
        LARVA_STATE_1 = 2;
        LARVA_reparation();
      } else {
      }
    }
    _;
  }
  int8 LARVA_STATE_1 = 0;
  int8 LARVA_STATE_2 = 0;
  int8 LARVA_STATE_3 = 0;
  function LARVA_reparation () private {
    revert();
  }
  function LARVA_satisfaction () private {
  }
  uint transferPreFrom;
  uint transferPreTo;
  uint transferFromPreFrom;
  uint transferFromPreTo;
  uint preAllowance;
  LARVA_STATUS private LARVA_Status = LARVA_STATUS.ENABLED;
  enum LARVA_STATUS {ENABLED, DISABLED}
  function LARVA_EnableContract () LARVA_ContractIsEnabled private {
    LARVA_Status = LARVA_STATUS.ENABLED;
  }
  function LARVA_DisableContract () LARVA_ContractIsEnabled private {
    LARVA_Status = LARVA_STATUS.DISABLED;
  }
  modifier LARVA_ContractIsEnabled {
    require(LARVA_Status == LARVA_STATUS.ENABLED);
    _;
  }
  ERC20TokenImplementation impl = ERC20TokenImplementation(0xE176bCd71ce7C8D2719c495c77947f69e0dD6E1D);
  address owner = 0xbCc06bC992FcfB190Ca24D83Ece05786c371b0aB;
  function updateImplementation (address newImpl) LARVA_ContractIsEnabled public {
    require(msg.sender == owner);
    impl = ERC20TokenImplementation(newImpl);
  }
  function totalSupply () LARVA_ContractIsEnabled public constant returns (uint) {
    return impl.totalSupply();
  }
  function balanceOf (address tokenOwner) LARVA_ContractIsEnabled public constant returns (uint balance) {
    return impl.balanceOf(tokenOwner);
  }
  function allowance (address tokenOwner, address spender) LARVA_ContractIsEnabled public constant returns (uint remaining) {
    return impl.allowance(tokenOwner, spender);
  }
  function transfer (address to, uint tokens) LARVA_DEA_1_handle_after_transfer__parameters_to_tokens(to, tokens) LARVA_DEA_1_handle_before_transfer__parameters_to_tokens(to, tokens) LARVA_ContractIsEnabled public returns (bool success) {
    return impl.transfer(msg.sender, to, tokens);
  }
  function approve (address spender, uint tokens) LARVA_DEA_3_handle_after_approve__parameters_spender_tokens(spender, tokens) LARVA_DEA_3_handle_before_approve__parameters_spender_tokens(spender, tokens) LARVA_ContractIsEnabled public returns (bool success) {
    return impl.approve(msg.sender, spender, tokens);
  }
  function transferFrom (address from, address to, uint tokens) LARVA_DEA_2_handle_after_transferFrom__parameters_from_to_tokens(from, to, tokens) LARVA_DEA_2_handle_before_transferFrom__parameters_from_to_tokens(from, to, tokens) LARVA_ContractIsEnabled public returns (bool success) {
    return impl.transferFrom(msg.sender, from, to, tokens);
  }

}
