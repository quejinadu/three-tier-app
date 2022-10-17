
output "loadbalancer" {
  value = aws_lb.cint_alb.dns_name
}