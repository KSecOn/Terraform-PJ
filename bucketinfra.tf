resource "aws_s3_bucket" "infra_bucket" {
  bucket = "upload_bucket_lifecycle"
# block: bucket
}

resource "aws_s3_bucket_versioning" "infra_versioning" {
    bucket = aws_s3_bucket.infra_bucket.id
  versioning_configuration {
    status = "Enabled"
# versionamento
  }
}

resource "aws_s3_bucket_ownership_controls" "control" {
  bucket = aws_s3_bucket.infra_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
# ownership control aplicado para uploads gerenciados apenas pelo proprietário
  }
}

resource "aws_s3_bucket_acl" "acl_infra_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.control]
# access control list depende de ownership control

  bucket = aws_s3_bucket.infra_bucket.id
  access_control_policy {
    grant {
      grantee {
        type = "CanonicalUser"
      }
      permission = "FULL_CONTROL"
# permissão de controle total
    }

    owner {
      id = data.example_user.current.id
# data owner id criada em main
    }
  }
}