jQuery ->
  $('#new_image').fileupload
    dataType: "script"
    add: (e, data) ->
      file = data.files[0]

      if file
        reader = new FileReader()

        reader.onload = (e) ->
          $('#image_preview').attr('src', e.target.result)

        reader.readAsDataURL(file);

        data.context = $(tmpl("template-upload", file))
        $('#new_image').append(data.context)
        data.submit()

    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')