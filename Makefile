# Build a boot2docker.iso image
# -----------------------------

image:
	docker image build -t marq/boot2docker-nfs .

iso:
	docker container run --rm marq/boot2docker-nfs > boot2docker-nfs.iso

clean:
	rm -f boot2docker-nfs.iso
