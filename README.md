# The Dappnet.

The Dappnet is a permissionless application network that can't be taken down. 

The Dappnet is a combination of technologies - [ENS](https://ens.domains/) as a permissionless name infrastructure, [IPFS](https://en.wikipedia.org/wiki/InterPlanetary_File_System) as a hypermedia protocol (like HTTP) and P2P CDN, and the browser as the application platform.

## How do I publish?

Here's what you'll need:

 * an ENS name (.eth).
 * the ipfs binary - the client is called Kubo (used to be go-ipfs) - [install them here](https://dist.ipfs.tech/#kubo).
 * a folder containing the files you're publishing.

How does it work?

 * IPFS is the content distribution network. 
 * In IPFS, content is referred to by its hash / content ID (CID). The common URL scheme is `/ipfs/QmXbY4RjwT2jwcUG4436n6FsnCWSuJegisatKrPwndpGu4`, where the latter part is the CID.
 * IPFS has a way to publish a name which can be updated to point to different content. This is called IPNS.
 * IPNS names are not the hash of content, but the hash of a public key. Only the owner of the keypair can update the IPNS name. An example is `/ipns/k51qzi5uqu5dlrejfo5zx3p4zqrcx0jcneixnsb4bchkt7akzg0w0tgyfddcub`, where the latter part is a hash of a public key.
 * To deploy a dapp, we will be publishing content to IPFS, and then updating the IPNS handle to point to this new content for every release.

Steps:

 1. In a separate terminal, start your IPFS node.

    ```sh
    ipfs daemon
    ```

 2. Generate an IPNS (IPFS Naming System) keypair. Your private keys will be located in `~/.ipfs/keystore/$KEYNAME`.

    ```sh
    ipfs key gen dapp-name
     
    # This will output your IPNS name.
    # $ ipfs key gen dapp-name
    # k51qzi5uqu5dlrejfo5zx3p4zqrcx0jcneixnsb4bchkt7akzg0w0tgyfddcub
    ```

 3. Publish a directory to IPFS.

    ```sh
    ipfs add -r example/

    # $ ipfs add -r example/
    # added QmNmKbdsVjHDzFRXZJKU7m7g7Ed8QpR1B66T3PFjK8q9Xn example/1.webp
    # added QmXbY4RjwT2jwcUG4436n6FsnCWSuJegisatKrPwndpGu4 example/2.jpg
    # added QmbGtM3BbPwujEEYdS11uAfc236ZHsgNYhs8rZufA3Y4Xa example/index.html
    # added QmYWY1EFwX1g2zuXGnSBA9T27LzvGdEpCyk9sR1GzicBG7 example
    # 86.14 KiB / 86.14 KiB [===============================================================================] 100.00%
    ```

    Each line is the IPFS CID for the path listed to the right of it. `QmYWY1EFwX1g2zuXGnSBA9T27LzvGdEpCyk9sR1GzicBG7` is the content ID of the `example/` directory. 

    You can test your content is on IPFS by connecting to any [IPFS gateway](https://github.com/ipfs/specs/blob/main/http-gateways/PATH_GATEWAY.md). Cloudflare runs a node which is pretty fast. You can try access the content on Cloudflare's gateway - [`cloudflare-ipfs.com/ipfs/.../`](https://cloudflare-ipfs.com/ipfs/QmYWY1EFwX1g2zuXGnSBA9T27LzvGdEpCyk9sR1GzicBG7/).

 4. Update your IPNS name to point to your IPFS content.

    From the output of the last command, copy the CID of your `build/` directory.

    And now we run the publish:
     
    ```sh
    ipfs name publish --key dapp-name YOUR_DIRECTORY_CID

    # $ ipfs name publish --key rollerskating QmYWY1EFwX1g2zuXGnSBA9T27LzvGdEpCyk9sR1GzicBG7
    # Published to k51qzi5uqu5dlrejfo5zx3p4zqrcx0jcneixnsb4bchkt7akzg0w0tgyfddcub: /ipfs/QmYWY1EFwX1g2zuXGnSBA9T27LzvGdEpCyk9sR1GzicBG7
    ```

    This will take ~20s. **NOTE: it doesn't display any logs/progress during this time, bit annoying I know.**.

    After this is done, you can access your IPNS site using a gateway. This time, the path is `/ipns/publicKeyHash`. For example, [`cloudflare-ipfs.com/ipns/.../`](https://cloudflare-ipfs.com/ipfs/QmYWY1EFwX1g2zuXGnSBA9T27LzvGdEpCyk9sR1GzicBG7/)

 5. Configure your .eth domain.
     
     Congratulations! This is the final step and you'll only have to do it once.

     We are going to configure your ENS domain's `content hash` to point to the IPNS name. This means lookups to your .eth will resolve to IPNS, which will resolve to the latest IPFS. **To update your `dapp.eth`, you only need to update your IPNS name**. It's all off-chain baby ;)

     Open the [ENS app](https://app.ens.domains/) and navigate to your domain. 

     Under "Records", click "Add/Edit Record". Select "Content".

     Enter `/ipns/`, and copy-paste your IPNS name from step 2.

     Then click "Save" and wait for the tx to confirm.

  6. Test your .eth domain.
  
      That's that! You should be able to access your domain on a .eth gateway.

      Open `<yourname>.eth.limo` to test in browser. For example, [rollerskating.eth](https://rollerskating.eth.limo/).


