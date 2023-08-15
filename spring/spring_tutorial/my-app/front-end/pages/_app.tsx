import { AppProps } from 'next/app';
import Head from 'next/head';
import { MantineProvider } from '@mantine/core';
import MyNav from '@/components/nav/my-nav';

export default function App(props: AppProps) {
  const { Component, pageProps } = props;

  return (
    <>
    
      {/* Header */}
      <Head>
        <title>Karma</title>
        <meta name="viewport" content="minimum-scale=1, initial-scale=1, width=device-width" />
      </Head>

      {/* Navbar */}
      <MyNav/>

      {/* Setting for mantine */}
      <MantineProvider
        withGlobalStyles
        withNormalizeCSS
        theme={{
          /** Put your mantine theme override here */
          colorScheme: 'light',
        }}
      >
        <Component {...pageProps} />
      </MantineProvider>
    </>
  );
}