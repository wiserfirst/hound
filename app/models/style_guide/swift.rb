module StyleGuide
  class Swift < Base
    LANGUAGE = "swift"
    JOB_CLASS = SwiftReviewJob

    def file_included?(_)
      true
    end
  end
end
