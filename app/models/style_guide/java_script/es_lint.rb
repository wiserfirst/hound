module StyleGuide
  module JavaScript
    class EsLint < Base
      LANGUAGE = "javascript"
      JOB_CLASS = EsLintReviewJob

      def file_included?(_)
        true
      end
    end
  end
end
