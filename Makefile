.PHONY: mychart
mychart:
	helm package src/mychart -d index/
	cd index && helm repo index .
