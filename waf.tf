module "waf" {
  source  = "umotif-public/waf-webaclv2/aws"
  version = "0.1.0"

  name_prefix = "grace-app"
  alb_arn     = aws_lb.app_waf_alb.elb.arn

  enable_CommonRuleSet          = true
  enable_AdminProtectionRuleSet = true
  enable_AmazonIpReputationList = true
  enable_AnonymousIpList        = true
  enable_SQLiRuleSet            = true


}
