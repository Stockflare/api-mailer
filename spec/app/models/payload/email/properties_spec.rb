describe Payload::Email::Properties do
  subject(:properties) { build(:payload_email_properties) }

  it { should respond_to(:TemplateKey) }

  it { should respond_to(:Data) }

  it { should_not respond_to(:TemplateKey=) }

  it { should_not respond_to(:Data=) }
end
