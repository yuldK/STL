# YTL

## Intro

C++ 표준 라이브러리를 직접 구현하는 학습용 저장소입니다.

- 헤더 파일로 이루어진 프로젝트입니다.
- C++20 표준을 기준으로 작성합니다.
- 헤더의 모든 파일은 ytd namespace에 속합니다.

## License

- MIT 라이선스를 준수합니다.

## Requirement

- C++20 이상
- 무결성 검증은 MSVC에서만 이루어집니다.
- 기능 테스트를 위한 프로젝트는 cmake로 생성합니다.

## Build

- 서브모듈로써 googletest가 필요합니다:
  - `git submodule update --init --recursive` 명령어를 사용하여 서브모듈을 초기화 해주세요.
- CMake를 사용하여 빌드합니다.
