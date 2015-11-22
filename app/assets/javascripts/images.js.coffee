jQuery ->
  $('#new_image').fileupload
    dataType: "script"
    add: (e, data) ->
      types = /(\.|\/)(gif|jpe?g|png)$/i
      file = data.files[0]

      if types.test(file.type)
        reader = new FileReader()

        reader.onload = (e) ->
          $('#image_preview').attr('src', e.target.result)

        reader.readAsDataURL(file)


        data.context = $(tmpl("template-upload", file))
        $('#new_image').append(data.context)
      else
        alert("#{file.name} is not a gif, jpeg, or png image file")

      data.submit()

    progress: (e, data) ->
      if data.context
        progress = parseInt(data.loaded / data.total * 100, 10)
        data.context.find('.bar').css('width', progress + '%')