
import logging
import os
import requests
import json
from Index import Index
from lxml import etree
log = logging.getLogger('POSTER')

class Poster:

    def __init__(self, input_folder, solr_service, site):
        # what to send to solr
        self.input_folder = input_folder

        # where to send it
        self.solr_service = solr_service

        # the site we're indexing
        self.site = site

        log.info('Poster initialised')
        
    def run(self):

        idx = Index(self.solr_service, self.site, "site_code:%s" % self.site)

        # wipe the old data from the index before rebuilding it
        idx.clean()
        idx.commit()

        for (dirpath, dirnames, filenames) in os.walk(self.input_folder):
            for f in filenames:
                file_handle = os.path.join(dirpath, f)

                doc = etree.parse(file_handle)
                idx.submit(etree.tostring(doc), file_handle)

            count = len(filenames)

        idx.commit()
        idx.optimize()

        # compare the local file count to what's in the index
        #  log an error if not the same
        url ="%s/select?q=site_code:%s&rows=0&wt=json" % (self.solr_service, self.site)
        data = json.loads(requests.get(url).text)
        if count != data['response']['numFound']:
            log.error("Number of files in index doesn't match local count. index: %s local: %s" % (data['response']['numFound'], count))