from brownie import accounts, GuessTheRandomNumber, Attack


def main():
    print("Deploying GuessTheRandomNumber...")
    grn = GuessTheRandomNumber.deploy(
        {"from": accounts[0], "value": "1 ether"})
    print(f"GuessTheRandomNumber deployed at {grn}")

    print("Deploying Attack...")
    att = Attack.deploy({"from": accounts[0]})
    print(f"Attack deployed at {att}")

    print("Calling Attack.attack on GuessTheRandomNumber with 1 ether...")
    tx = att.attack(grn.address, {"from": accounts[0], "value": "1 ether"})
    tx.wait(1)
    print(f"Attack balance is {att.getBalance()}")
