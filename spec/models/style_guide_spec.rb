require "rails_helper"

describe StyleGuide do
  describe ".for" do
    context "given a ruby file" do
      it "returns `StyleGuide::Ruby`" do
        filename = "hello.rb"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::Ruby
      end
    end

    context "given a swift file" do
      it "returns `StyleGuide::Swift`" do
        filename = "hello.swift"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::Swift
      end
    end

    context "given a javascript file" do
      context "when a custom linter is specified" do
        it "returns the custom linter" do
          filename = "hello.js"
          config = build_config(
            custom_linter?: true,
            custom_linter: "es_lint",
          )

          klass = build_style_guide(filename: filename, config: config)

          expect(klass).to eq StyleGuide::JavaScript::EsLint
        end

        context "when the specified linter does not exist" do
          it "falls back to JsHint" do
            filename = "hello.js"
            config = build_config(
              custom_linter?: true,
              custom_linter: "arbitrary",
            )

            klass = build_style_guide(filename: filename, config: config)

            expect(klass).to eq StyleGuide::JavaScript::JsHint
          end
        end
      end

      context "when a custom linter not is specified" do
        it "returns `StyleGuide::JavaScript::JsHint`" do
          filename = "hello.js"

          klass = build_style_guide(filename: filename)

          expect(klass).to eq StyleGuide::JavaScript::JsHint
        end
      end
    end

    context "when a coffeescript file is given" do
      it "supports `coffee.js` as an extension" do
        filename = "hello.coffee.js"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::CoffeeScript
      end

      it "returns `StyleGuide::CoffeeScript`" do
        filename = "hello.coffee"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::CoffeeScript
      end
    end

    context "given a go file" do
      it "returns `StyleGuide::Go`" do
        filename = "hello.go"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::Go
      end
    end

    context "given a haml file" do
      it "returns `StyleGuide::Haml`" do
        filename = "hello.haml"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::Haml
      end
    end

    context "given a scss file" do
      it "returns `StyleGuide::Scss`" do
        filename = "hello.scss"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::Scss
      end
    end

    context "given a file that is not supported" do
      it "returns `Unsupported`" do
        filename = "hello.whatever"

        klass = build_style_guide(filename: filename)

        expect(klass).to eq StyleGuide::Unsupported
      end
    end
  end

  def build_style_guide(filename:, config: build_config())
    StyleGuide.for(filename, config)
  end

  def build_config(options = {})
    default_options = {
      custom_linter?: false,
    }

    double("RepoConfig", default_options.merge(options))
  end
end
