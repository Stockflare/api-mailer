# Provides a Domain specific wrapper for environment variables that would
# otherwise be referenced throughout the entire application. Which would
# be ugly as sin.
module Mailer
  # The bucket where all email templates are located
  #
  # @note This field is required. There is no default.
  #
  # @return [string] s3 bucket name
  BUCKET = String(ENV['BUCKET_NAME'] || raise('aws s3 bucket name missing'))

  # The Name of the AWS Kinesis Stream
  #
  # @note This field is required. There is no default.
  #
  # @return [string] kinesis stream name
  STREAM = String(ENV['STREAM_NAME'] || raise('aws kinesis stream name missing'))

  # The reply email address attached to all emails
  #
  # @note This field is required. There is no default.
  #
  # @return [string] reply email address
  FROM = String(ENV['DEFAULT_FROM'] || raise('reply-to email address missing'))
end
