$( () => {
    if ($('.projectsshow').length > 0) {
        var id = $('.title').attr('id')
        $.get(`/projects/${id}/tasks`, (data) => {
            $.each(data, (index, task) => {
                $(`#task-${task.id}`).appendTo(`#${task.stage}`);
            });
        }, 'JSON');
    };
});

