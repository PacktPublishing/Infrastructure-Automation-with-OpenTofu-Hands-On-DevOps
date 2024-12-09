resource "aws_dynamodb_table" "thinknyx_lock_dynamodb" {
    name = "thinknyx_dynamodb_lock_table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    
    attribute {
        name = "LockID"
        type = "S"
    }

    tags = {
        Name = "Thinknyx DynamoDB Lock table"
    }


}