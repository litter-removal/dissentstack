# SPDX-License-Identifier: AGPL-3.0-or-later
"""
 Google (Videos)
"""

from datetime import date, timedelta
from urllib.parse import urlencode
from lxml import html
from searx.utils import extract_text, eval_xpath, eval_xpath_list, eval_xpath_getindex
import re

# about
about = {
    "website": 'https://www.google.com',
    "wikidata_id": 'Q219885',
    "official_api_documentation": 'https://developers.google.com/custom-search/',
    "use_official_api": False,
    "require_api_key": False,
    "results": 'HTML',
}

# engine dependent config
categories = ['videos']
paging = True
safesearch = True
time_range_support = True
number_of_results = 10

search_url = 'https://www.google.com/search'\
    '?q={query}'\
    '&tbm=vid'\
    '&{search_options}'
time_range_attr = "qdr:{range}"
time_range_custom_attr = "cdr:1,cd_min:{start},cd_max{end}"
time_range_dict = {'day': 'd',
                   'week': 'w',
                   'month': 'm'}


# do search-request
def request(query, params):
    search_options = {
        'ijn': params['pageno'] - 1,
        'start': (params['pageno'] - 1) * number_of_results
    }

    if params['time_range'] in time_range_dict:
        search_options['tbs'] = time_range_attr.format(range=time_range_dict[params['time_range']])
    elif params['time_range'] == 'year':
        now = date.today()
        then = now - timedelta(days=365)
        start = then.strftime('%m/%d/%Y')
        end = now.strftime('%m/%d/%Y')
        search_options['tbs'] = time_range_custom_attr.format(start=start, end=end)

    if safesearch and params['safesearch']:
        search_options['safe'] = 'on'

    params['url'] = search_url.format(query=urlencode({'q': query}),
                                      search_options=urlencode(search_options))

    return params


# get response from search-request
def response(resp):
    results = []

    dom = html.fromstring(resp.text)

    # parse results
    for result in eval_xpath_list(dom, '//div[@class="g"]'):

        title = extract_text(eval_xpath(result, './/h3'))
        url = eval_xpath_getindex(result, './/div[@class="r"]/a/@href', 0)
        content = extract_text(eval_xpath(result, './/span[@class="st"]'))

        # get thumbnails
        script = str(dom.xpath('//script[contains(., "_setImagesSrc")]')[0].text)
        ids = result.xpath('.//div[@class="s"]//img/@id')
        if len(ids) > 0:
            thumbnails_data = \
                re.findall('s=\'(.*?)(?:\\\\[a-z,1-9,\\\\]+\'|\')\;var ii=\[(?:|[\'vidthumb\d+\',]+)\'' + ids[0],
                           script)
            tmp = []
            if len(thumbnails_data) != 0:
                tmp = re.findall('(data:image/jpeg;base64,[a-z,A-Z,0-9,/,\+]+)', thumbnails_data[0])
            thumbnail = ''
            if len(tmp) != 0:
                thumbnail = tmp[-1]

        # append result
        results.append({'url': url,
                        'title': title,
                        'content': content,
                        'thumbnail': thumbnail,
                        'template': 'videos.html'})

    return results
