module DefaultAssociationAttributes
  def build_record(attrs, &block)
    super(with_default_attributes(attrs), &block)
  end

  def create_record(attrs, &block)
    super(with_default_attributes(attrs), &block)
  end

  def with_default_attributes(attrs)
    default_attributes.merge((attrs || {}).symbolize_keys)
  end
end
