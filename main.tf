resource "aws_sqs_queue" "sqs" {
  name                       = "${local.prefix}-${var.queue_name}"
  visibility_timeout_seconds = var.visibility_timeout
  delay_seconds              = 0
  max_message_size           = 262144
  message_retention_seconds  = 345600 # 4 days
  receive_wait_time_seconds  = 20     # Enable Long pooling
  redrive_policy             = "{\"deadLetterTargetArn\":\"${aws_sqs_queue.sqs_dead_letter.arn}\",\"maxReceiveCount\":${var.max_receive_count}}"
}

resource "aws_sqs_queue" "sqs_dead_letter" {
  name                      = "sqs-${var.queue_name}-deadletter-queue"
  delay_seconds             = 0
  max_message_size          = 262144
  message_retention_seconds = 1209600 # 14 days.
  receive_wait_time_seconds = 20
}

