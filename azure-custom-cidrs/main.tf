module "tags_standards_prod" {
  source = "git::https://conagra@dev.azure.com/conagra/cloud-services/_git/shared-infra-modules//modules/tagging?ref=v1.0.1-tagging"

  ApplicationID        = "16396"
  Environment          = "Production"
  MetalTier            = "Gold"
  DisasterRecoveryTier = "5"
  Portfolio            = "Cloud Infrastructure & Operations"
  Product              = "Data Center"
  Repo                 = "azure-terraform-conagra-custom-cidr"
  ADOProject           = "data-center-and-network-services"
}

resource "azurerm_resource_group" "rg_for_cidr_prefix" {
  name     = "rg-global-custom-cidr"
  location = "North Central US"

  tags = module.tags_standards_prod.tags
}

resource "azurerm_custom_ip_prefix" "cdir_global" {
  name                = "cidr-global01"
  location            = azurerm_resource_group.rg_for_cidr_prefix.location
  resource_group_name = azurerm_resource_group.rg_for_cidr_prefix.name

  commissioning_enabled         = false
  internet_advertising_disabled = false

  cidr                          = "1.2.3.4/23"                                                                                                                                                                                                                                                                                                                                          #managed in ARIN via the Network Team. ROA blocks IPs not from this /23 from being advertised over ASN8075 from MSFT.
  roa_validity_end_date         = "YYYY-MM-DD"                                                                                                                                                                                                                                                                                                                                               #NEEDED FROM NETWORK
  wan_validation_signed_message = "<signed_string_here>" #NEEDED FROM NETWORK


  tags = module.tags_standards_prod.tags

}

resource "azurerm_custom_ip_prefix" "ncus_regional" {
  name                          = "cidr-ncus-region01"
  location                      = "North Central US"
  resource_group_name           = azurerm_resource_group.rg_for_cidr_prefix.name
  parent_custom_ip_prefix_id    = azurerm_custom_ip_prefix.cdir_global.id
  commissioning_enabled         = true
  internet_advertising_disabled = true
  cidr                          = "1.2.3.4/26"
  #zones = ["1", "2", "3"] NCUS does not support Zones

  tags = module.tags_standards_prod.tags
}

resource "azurerm_public_ip_prefix" "ncus_public_prefix" {
  name                = "public-ncus-prefix"
  location            = azurerm_custom_ip_prefix.ncus_regional.location
  resource_group_name = azurerm_resource_group.rg_for_cidr_prefix.name
  #zones               = ["1", "2", "3"] #NCUS Does not support zones

  prefix_length = 26

  tags = module.tags_standards_prod.tags

}

resource "azurerm_custom_ip_prefix" "cus_regional" {
  name                          = "cidr-cus-region01"
  location                      = "Central US"
  resource_group_name           = azurerm_resource_group.rg_for_cidr_prefix.name
  parent_custom_ip_prefix_id    = azurerm_custom_ip_prefix.cdir_global.id
  commissioning_enabled         = true
  internet_advertising_disabled = true
  cidr                          = "1.2.3.4/26"
  zones                         = ["1", "2", "3"]

  tags = module.tags_standards_prod.tags

}

resource "azurerm_public_ip_prefix" "cus_public_prefix" {
  name                = "public-cus-prefix"
  location            = azurerm_custom_ip_prefix.cus_regional.location
  resource_group_name = azurerm_resource_group.rg_for_cidr_prefix.name
  zones               = ["1", "2", "3"]

  prefix_length = 26

  tags = module.tags_standards_prod.tags

}

resource "azurerm_custom_ip_prefix" "eus2_regional" {
  name                          = "cidr-eus2-region01"
  location                      = "East US 2"
  resource_group_name           = azurerm_resource_group.rg_for_cidr_prefix.name
  parent_custom_ip_prefix_id    = azurerm_custom_ip_prefix.cdir_global.id
  commissioning_enabled         = true
  internet_advertising_disabled = true
  cidr                          = "1.2.3.4/26"
  zones                         = ["1", "2", "3"]

  tags = module.tags_standards_prod.tags

}

resource "azurerm_public_ip_prefix" "eus2_public_prefix" {
  name                = "public-eus2-prefix"
  location            = azurerm_custom_ip_prefix.eus2_regional.location
  resource_group_name = azurerm_resource_group.rg_for_cidr_prefix.name
  zones               = ["1", "2", "3"]

  prefix_length = 26

  tags = module.tags_standards_prod.tags

}

resource "azurerm_custom_ip_prefix" "scus_regional" {
  name                          = "cidr-scus-region01"
  location                      = "South Central US"
  resource_group_name           = azurerm_resource_group.rg_for_cidr_prefix.name
  parent_custom_ip_prefix_id    = azurerm_custom_ip_prefix.cdir_global.id
  commissioning_enabled         = true
  internet_advertising_disabled = true
  cidr                          = "204.76.111.128/26"
  zones                         = ["1", "2", "3"]

  tags = module.tags_standards_prod.tags

}

resource "azurerm_public_ip_prefix" "scus_public_prefix" {
  name                = "public-scus-prefix"
  location            = azurerm_custom_ip_prefix.scus_regional.location
  resource_group_name = azurerm_resource_group.rg_for_cidr_prefix.name
  zones               = ["1", "2", "3"]
  
  prefix_length       = 26

  tags = module.tags_standards_prod.tags

}
resource "azurerm_custom_ip_prefix" "cin_regional" {
  name                          = "cidr-cin-region01"
  location                      = "Central India"
  resource_group_name           = azurerm_resource_group.rg_for_cidr_prefix.name
  parent_custom_ip_prefix_id    = azurerm_custom_ip_prefix.cdir_global.id
  commissioning_enabled         = true
  internet_advertising_disabled = true
  cidr                          = "1.2.3.4/26"
  zones                         = ["1", "2", "3"]

  tags = module.tags_standards_prod.tags

}

resource "azurerm_public_ip_prefix" "cin_public_prefix" {
  name                = "public-cin-prefix"
  location            = azurerm_custom_ip_prefix.cin_regional.location
  resource_group_name = azurerm_resource_group.rg_for_cidr_prefix.name
  zones               = ["1", "2", "3"]

  prefix_length = 26

  tags = module.tags_standards_prod.tags

}
