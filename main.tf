module "child" {
  source = ".//child"

}

resource "aws_budgets_budget" "monthly-budget" {
  name              = "monthly-budget-${module.child.pet-name}-${module.child.number-result}"
  budget_type       = "COST"
  limit_amount      = "100"
  limit_unit        = "USD"
  time_period_start = "2020-09-01_00:00"
  time_unit         = "MONTHLY"

  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = ["user@example.com"]
  }
}
terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    workspaces {
      name = "monthly-budget"
    }
  }
}