output "ec2_public_ip" {
  value = aws_instance.demo_ec2.public_ip
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}
