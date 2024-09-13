resource "azurerm_web_application_firewall_policy" "waf" {
  for_each            = var.waf
  name                = each.value.waf_name
  resource_group_name = each.value.rgname
  location            = each.value.location

  custom_rules {
    name      = "GaggiURI"
    priority  = 1
    rule_type = "MatchRule"
    action    = "Allow"
    enabled   = true

    match_conditions {
      match_values = [
                "gaggidevops.online",
            ]
      negation_condition = false
      operator           = "Contains"
      transforms         = [
                "UrlEncode",
            ]
      match_variables {
        selector      = null
        variable_name = "RequestUri"
      }
    }

  }
  managed_rules {
    exclusion {
      match_variable          = "RequestArgNames"
      selector                = "x-company-secret-header"
      selector_match_operator = "EqualsAny"
    }
    exclusion {
            match_variable          = "RequestHeaderNames"
            selector                = "User-Agent"
            selector_match_operator = "Contains"

            excluded_rule_set {
                type    = "OWASP"
                version = "3.2"

                rule_group {
                    excluded_rules  = [
                        "913101",
                    ]
                    rule_group_name = "REQUEST-913-SCANNER-DETECTION"
                }
                rule_group {
                    excluded_rules  = [
                        "920230",
                        "920300",
                        "920320",
                        "920350",
                    ]
                    rule_group_name = "REQUEST-920-PROTOCOL-ENFORCEMENT"
                }
            }
        }
        managed_rule_set {
            type    = "OWASP"
            version = "3.2"
        }
    }

    policy_settings {
        enabled                          = true
        file_upload_limit_in_mb          = 100
        max_request_body_size_in_kb      = 128
        mode                             = "Detection"
        request_body_check               = true
        request_body_inspect_limit_in_kb = 128
    }
        tags                                = {
        "Deployment Name"  = "IaC POC"
        "Deployment Owner" = "Rajiv Tanwar"
        "Backup"            = "No"
        "Creation Date"     = "09-Aug-2024"
        "Environment"       = "Uat"
        "SLA"               = "INS_SCR_001"
    }
}



