$ ->

  $("#related_activities_selector").chosen()

  $('.script-text').readmore()

  $("#activity_is_free").on "change", ->
    if $(this).val() == "true"
      $(".price-input-container").hide()
    else
      $(".price-input-container").show()

  $("#create-new-activity-button").on "click", ->
    if $("#new-activity-main-title").val() != "" and $("#new_category_select_id").val() != ""
      params =
        main_title: $("#new-activity-main-title").val()
        category_id: $("#new_category_select_id").val()

      $.ajax
        url: "/activities"
        type: "POST"
        dataType: "json"
        data: params

        success: (data) ->
          console.log data.activity._id.$oid
          window.location.replace("/admin/activities/#{data.activity._id.$oid}/edit")
    else
      alert("Enter a name and select a category")

  $(".delete-activity").on "click", ->
    if confirm("Are you sure?")
      activityId = $(this).data("activity-id")
      $.ajax
        url: "/activities/#{activityId}"
        type: "DELETE"
        dataType: "json"
        success: (data) ->
          console.log data
          $("li[data-activity-id=#{activityId}]").remove()


  $('.sub-categories').iosSlider(
    scrollbar: true
    snapToChildren: true
    desktopClickDrag: true
    infiniteSlider: true
    # navSlideSelector: $('.iosSliderButtons .button')
    scrollbarHeight: '2px'
    scrollbarBorderRadius: '0'
    scrollbarOpacity: '0.5'
    onSlideChange: slideContentChange
    onSliderLoaded: slideContentChange
    keyboardControls: true
  )

  $(".next-slide, .previous-slide").on "click", ->
    $("##{"slider-#{$(this).data("slider-id")}"}").iosSlider($(this).data("direction"))
        
window.slideContentChange = (args) ->
  # indicator
  # $('.iosSliderButtons .button').removeClass('selected');
  # $('.iosSliderButtons .button:eq(' + (args.currentSlideNumber - 1) + ')').addClass('selected');