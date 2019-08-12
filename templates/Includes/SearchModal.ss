<div class="modal modal-search fade" id="modalSearch" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <form class="search-form">
                    <input autocomplete="off" type="text" size="10" class="search-form__input st-default-search-input" name="search"
                           aria-label="Search SilverStripe" spellcheck="false" placeholder="Search SilverStripe...">
                    <button class="search-form__button" type="submit">
                        <% include SearchSvg %>
                    </button>
                </form>
                <div class="st-search-container"></div>
            </div>
        </div>
    </div>
</div>
