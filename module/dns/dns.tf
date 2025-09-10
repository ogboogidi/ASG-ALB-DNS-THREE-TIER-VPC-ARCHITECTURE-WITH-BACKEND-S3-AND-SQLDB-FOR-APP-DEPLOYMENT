
#fetch the domain name already created in route 53
data "aws_route53_zone" "domain_name" {
  name = "momentstravel.org"
}


#create an A record for the apex domain with an alias

resource "aws_route53_record" "A_record" {
  zone_id = data.aws_route53_zone.domain_name.zone_id
  name = data.aws_route53_zone.domain_name.name
  type = "A"

  alias {
    zone_id = var.luxe_alb_id
    name = var.alb_dns_name
    evaluate_target_health = true
  }
}

