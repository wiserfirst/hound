module StyleGuide
  module JavaScript
    class EsLint < Base
      LANGUAGE = "es_lint"

      def file_included?(_)
        true
      end
    end
  end
end
