from brownie import accounts, config, SimpleStorage

def deploy_simple_storage():
    account = accounts[0]
    simple_storage = SimpleStorage.deploy({"from": account})
    storage_value = simple_storage.retrieve()
    print(storage_value)
    transaction = simple_storage.store(15, {"from": account})
    transaction.wait(1)
    update_stored_value = simple_storage.retrieve()
    print(update_stored_value)

def main():
    deploy_simple_storage()