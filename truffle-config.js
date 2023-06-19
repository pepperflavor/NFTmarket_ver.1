module.exports = {
  networks: {
    // ganache 네트워크로 설정
    development: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 7545, // Standard Ethereum port (default: none)
      network_id: "*", // Any network (default: none)
    },
  },

  // 컨트랙트 위치 지정
  contracts_directory: "./src/contracts/",
  // ABI 위치 지정
  contracts_build_directory: "./src/abis",

  compilers: {
    solc: {
      version: "0.8.19", // Fetch exact version from solc-bin (default: truffle's version)
      optimizer: {
        enabled: "true",
        runs: 200, // 프로젝트 크기에따라 최적화하려는 방식에따라 설정해줌
      },
    },
  },
};
