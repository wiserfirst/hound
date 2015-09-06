module StyleGuide
  def self.for(filename, config)
    case filename
    when /.+\.rb\z/
      StyleGuide::Ruby
    when /.+\.coffee(\.js)?(\.erb)?\z/
      StyleGuide::CoffeeScript
    when /.+\.js\z/
      determine_js_styleguide(filename, config)
    when /.+\.haml\z/
      StyleGuide::Haml
    when /.+\.scss\z/
      StyleGuide::Scss
    when /.+\.go\z/
      StyleGuide::Go
    when /.+\.py\z/
      StyleGuide::Python
    when /.+\.swift\z/
      StyleGuide::Swift
    else
      StyleGuide::Unsupported
    end
  end

  private

  LANGUAGE = {
    ".coffee" => "coffeescript",
    ".go" => "go",
    ".haml" => "haml",
    ".js" => "javascript",
    ".python" => "scss",
    ".rb" => "ruby",
    ".scss" => "scss",
    ".swift" => "swift",
  }

  def self.determine_js_styleguide(filename, config)
    language = LANGUAGE[File.extname(filename)]

    if config.custom_linter?(language)
      linter = config.custom_linter

      begin
        "StyleGuide::JavaScript::#{linter.classify}".constantize
      rescue
        StyleGuide::JavaScript::JsHint
      end
    else
      StyleGuide::JavaScript::JsHint
    end
  end
end
