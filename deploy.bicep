param accountName string = 'example'

param identityId string = deployer().objectId

resource account 'Microsoft.DocumentDB/databaseAccounts@2024-05-15' existing = {
  name: accountName
  resource role 'sqlRoleDefinitions@2024-12-01-preview' existing = {
    name: '00000000-0000-0000-0000-000000000002'
  }
  resource assignment 'sqlRoleAssignments@2024-05-15' = {
    name: guid(account::role.id, identityId, account.id)
    properties: {
      principalId: identityId
      roleDefinitionId: account::role.id
      scope: account.id
    }
  }
}
