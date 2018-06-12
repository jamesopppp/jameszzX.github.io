<aside class="page__sidebar">
    <!-- {% if get_setting('qrcode', 'avatar') %}
        <div class="sidebar__img">
            <img src="{{ get_setting('qrcode', 'avatar') }}" alt="{{ get_setting('title') }}" title="{{ get_setting('title') }}">
        </div>
    {% endif %} -->

    <form id="page-search-from" class="page__search-from" action="/search/">
        <label class="search-form__item">
            <input class="input" type="text" name="search" placeholder="Search...">
            <i class="iconfont icon-search"></i>
        </label>
    </form>
    
    <div style="margin: 30px 0 0 0">
        <iframe frameborder="no" border="0" marginwidth="0" marginheight="0" width=330 height=450 src="//music.163.com/outchain/player?type=0&id=2220579313&auto=1&height=430"></iframe>
    </div>
    {% if get_setting('description') %}
        <div class="sidebar__block">
            <h3 class="block__title">{{ __('aside.introduction') }}</h3>
            <p class="block__text">{{ get_setting('description') }}</p>
        </div>
    {% endif %}

    <div class="sidebar__block">
        <h3 class="block__title">{{ __('aside.categorie') }}</h3>
        {{ list_categories({ order: -1, class: 'block' }) }}
    </div>
    
    <div class="sidebar__block">
        <h3 class="block__title">{{ __('aside.latest_post') }}</h3>
        {{ latest_post(4) }}
    </div>

    <div class="sidebar__block">
        <h3 class="block__title">{{ __('aside.tag') }}</h3>
        {{ tags({ order: -1 }) }}
    </div>

    <!-- <div class="sidebar__block">
        <h3 class="block__title">{{ __('aside.friend_links') }}</h3>
        <ul class="block-list">
            {% for item in site.data.link %}
                <li class="block-list-item">
                    <a class="block-list-link" href="{{ item.link }}" title="{{ item.desc }}" target="_blank">{{ item.name }}</a>
                </li>
            {% endfor %}
        </ul>
    </div> -->
</aside>