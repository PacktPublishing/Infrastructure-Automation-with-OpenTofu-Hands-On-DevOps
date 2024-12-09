resource "aws_s3_bucket" "thinknyx_bucket" {
    bucket = "thinknyx-dev"
    force_destroy = true
    
    tags = {
        Name = "Thinknyx Bucket"
        Environment = "Dev"
    }
}