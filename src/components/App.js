import React, { Component } from "react";
import Web3 from "web3";
import detectEthereumProvider from "@metamask/detect-provider";
import KryptoBird from "../abis/KryptoBird.json";
import {
  MDBCard,
  MDBCardBody,
  MDBCardTitle,
  MDBCardText,
  MDBCardImage,
  MDBBtn,
} from "mdb-react-ui-kit";
import "./App.css";

/* cssgradient.io */
class App extends Component {
  async componentDidMount() {
    await this.loadWeb3();
    await this.loadBlockchainData();
  }

  // 처음페이지를 랜더링 할때 이더리움 제공자 확인,
  // 메타마스크가 실행되고 계정에 연결되어있는지 확인
  // function이 없지만 암묵적인 함수
  async loadWeb3() {
    // "@metamask/detect-provider"; 라이브러리에 있는 기능으로 지갑연결
    const provider = await detectEthereumProvider();

    // 최신브라우저인지 확인
    if (provider) {
      console.log("Ethereum wallet is connected!");
      window.web3 = new Web3(provider); // 대문자는 라이브러리를 뜻함
    } else if (provider !== window.ethereum) {
      console.log("NO Ethereum wallet detected!");
    }
  }

  async loadBlockchainData() {
    const web3 = window.web3;
    // 계정을 못갖고오는데...?
    const accounts = await window.ethereum
      .request({ method: "eth_requestAccounts" })
      .catch((err) => {
        if (err.code === 4001) {
          console.log("Please connect to MetaMarsk");
        } else {
          console.log(err);
        }
      });
    const myaccount = accounts[0];
    //await web3.eth.getAccounts();
    this.setState({ account: myaccount });

    const networkId = await web3.eth.net.getId();
    const networkData = KryptoBird.networks[networkId];
    if (networkData) {
      // contract 주소
      const abi = KryptoBird.abi;
      const address = networkData.address;
      const contract = new web3.eth.Contract(abi, address);
      this.setState({ contract: contract });

      // NFT 총 공급량
      const totalSupply = await contract.methods.totalSupply().call();
      this.setState({ totalSupply: totalSupply });

      // 토큰 추적을 위한 배열
      for (let i = 1; i <= totalSupply; i++) {
        // KryptoBird = await contract.mint(`https...${i}`);
        // 위에 처럼 직접 집어넣는걸 생각했는데 KryptoBird contract에 만들어둔
        // 배열에 있는 값을 가져오는 방법이 맞다....
        const KryptoBird = await contract.methods.kryptoBirdz(i - 1).call();
        this.setState({
          kryptoBirdz: [...this.state.kryptoBirdz, KryptoBird],
        });
      }
      console.log(this.state.kryptoBirdz);
    } else {
      // 실패시
      window.alert("Smart contract not deployed!");
    }
    //const money = await web3.eth.getBalance(this.state.account);
    //console.log(money);
  }

  // 민팅기능 함수
  // .once()로 한번만 기능하도록 설정
  // 주소가 지정되지 않았다고 오류뜸ㅠㅠ =>  지갑주소 불러오는 방식을 바꿨다
  mint = (kryptoBird) => {
    this.state.contract.methods
      .mint(kryptoBird)
      .send({ from: this.state.account })
      .once("receipt", (receipt) => {
        this.setState({
          kryptoBirdz: [...this.state.kryptoBirdz, KryptoBird],
        });
      });
  };

  //   async getMetaMarskAccount() {
  //     const accounts = await window.ethereum
  //       .request({ method: "eth_requestAccounts" })
  //       .catch((err) => {
  //         if (err.code === 4001) {
  //           console.log("Please connect to MetaMarsk");
  //         } else {
  //           console.log(err);
  //         }
  //       });
  //     const account = accounts[0];
  //     this.setState({account : account});
  //   }

  // 소각, 전송함수 추가

  constructor(props) {
    super(props);
    this.state = {
      account: "",
      contract: null,
      totalSupply: 0,
      kryptoBirdz: [],
    };
  }

  render() {
    return (
      <div className="container-filled">
        <nav className="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
          <div
            className="navbar-brand col-sm-3 col-md-3 mr-0"
            style={{ color: "white" }}
          >
            Krypto Birdz NFTs ( Non Fungible Tokens )
          </div>
          <ul className="navbar-nav px-3">
            <li className="nav-item text-nowrap d-none d-sm-none d-sm-block">
              <small className="text-white">{this.state.account}</small>
            </li>
          </ul>
        </nav>
        <></>
        <div className="container-fluid mt-1">
          <div className="row">
            <main role="main" className="col-lg-12 d-flex text-center">
              <div
                className="content mr-auto ml-auto"
                style={{ opacity: "0.8" }}
              >
                <h1 style={{ color: "black" }}>
                  kryptoBirdz - NFT Market Place
                </h1>

                <form
                  onSubmit={(event) => {
                    event.preventDefault();
                    const kryptoBird = this.kryptoBird.value;
                    this.mint(kryptoBird);
                  }}
                >
                  <input
                    type="text"
                    name="nft-name"
                    placeholder="NFT image location"
                    className="form-control mb-1"
                    ref={(input) => {
                      this.kryptoBird = input;
                    }}
                  />
                  <input
                    style={{ margin: "6px" }}
                    type="submit"
                    className="btn btn-primary btn-black"
                    value="MINT"
                  />
                </form>
              </div>
            </main>
          </div>
          <hr></hr>
          <div className="row textCenter">
            {this.state.kryptoBirdz.map((kryptoBird, key) => {
              return (
                <div>
                  <div>
                    <MDBCard
                      className="token img"
                      style={{ maxWidth: "22rem" }}
                    >
                      <MDBCardImage
                        src={kryptoBird}
                        position="top"
                        style={{ marginRight: "4px" }}
                        heigth={"250rem"}
                      />
                      <MDBCardBody>
                        <MDBCardTitle> KRYPTOBirdz </MDBCardTitle>
                        <MDBCardText>
                          The KryptoBirdz NFTs are from the META world! There is
                          only one of each bird and each bird can be owned by a
                          single person on the Ethereum blockchain.
                        </MDBCardText>
                        <MDBBtn href={kryptoBird}>Download</MDBBtn>
                      </MDBCardBody>
                    </MDBCard>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </div>
    );
  }
}

export default App;
