$(window).on('turbo:load', function() {
    cancelConfirm();
});
$(window).on('DOMContentLoaded', function() {
    cancelConfirm();
});

const cancelConfirm = () => {
    $(document).on('mouseenter', 'button.delete-confirm-button', function() {
        const name = $(this).data('name');
        const url = $(this).data('url');
        var $targetModal = $('#deleteConfirmModal');
        $targetModal.find('#modalTitle').text(name);
        $targetModal.find('#deleteButton').attr("href", url);
    })
};