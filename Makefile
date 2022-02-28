DATA_DIR=./data/DewarpNet
DOC3D_DIR=$(DATA_DIR)/doc3d
DTD_DIR=$(DATA_DIR)/dtd

all: $(DOC3D_DIR)/images.txt $(DATA_DIR)/augtexnames.txt

$(DOC3D_DIR)/images.txt:
	for i in $$(ls $(DOC3D_DIR)/img); do \
		ls -l $(DOC3D_DIR)/img/$$i/*.png | awk '{print substr($$9, 28)}' | sed "s/.png//g" >> $@; \
	done
	awk -v train="train.txt" -v valid="val.txt" '{if(rand()<0.9) {print > train} else {print > valid}}' $@
	mv train.txt $(DOC3D_DIR)/
	mv val.txt $(DOC3D_DIR)/

$(DATA_DIR)/augtexnames.txt:
	for category in $$(ls $(DTD_DIR)/images); do \
		ls -l $(DTD_DIR)/images/$$category/*.jpg | awk '{print substr($$9, 18)}' >> $@; \
	done

clean:
	rm -f $(DOC3D_DIR)/images.txt
	rm -f $(DOC3D_DIR)/train.txt
	rm -f $(DOC3D_DIR)/val.txt
	rm -f $(DATA_DIR)/augtexnames.txt
