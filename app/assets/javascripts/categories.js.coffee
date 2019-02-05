$ ->

  # $(".sub-category-name, .sub-category-options-container").mouseover(->
  #   $(".sub-category-options-container[data-category-id=#{$(this).data("category-id")}]").css("display", "inline-block")
  # ).mouseout ->
  #   categoryId = $(this).data("category-id")
  #   setTimeout (->
  #     $(".sub-category-options-container[data-category-id=#{categoryId}]").css("display", "none")
  #     # Do something after 5 seconds
  #   ), 500

  applyResponsiveness = ->
    if $(window).width() < 768
      $(".categories .activity-item-container .avatar-container .avatar").css("width", "#{$(window).width() - 30}px").css("height", "#{$(window).width()/2 + 45}px")

  $(window).on("orientationchange", ->
    applyResponsiveness()
  )

  applyResponsiveness()

  $("#city").on "change", ->
    window.location = '?city=' + this.value

  $(".delete-category").on "click", ->
    if confirm("Are you sure?")
      categoryId = $(this).data("category-id")
      $.ajax
        url: "/categories/#{categoryId}"
        type: "DELETE"
        dataType: "json"
        success: (data) ->
          $("li[data-category-id=#{categoryId}]").remove()
        error: (XMLHttpRequest, textStatus, errorThrown) ->
          alert "You can't delete this category because has children. Move the children to another category or delete"
