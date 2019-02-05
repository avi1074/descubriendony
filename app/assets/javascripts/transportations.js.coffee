$ ->

  $(".delete-transportation").on "click", ->
    if confirm("Are you sure?")
      transportationId = $(this).data("transportation-id")
      $.ajax
        url: "/transportations/#{transportationId}"
        type: "DELETE"
        dataType: "json"
        success: (data) ->
          console.log data
          $("li[data-transportation-id=#{transportationId}]").remove()

