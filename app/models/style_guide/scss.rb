module StyleGuide
  class Scss < Base
    LANGUAGE = "scss"
    JOB_CLASS = ScssReviewJob

    def file_included?(_)
      true
    end
  end
end
