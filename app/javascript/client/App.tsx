import React, { useEffect, useState } from 'react';
import { QueryClient, QueryClientProvider } from 'react-query';
import { ReactQueryDevtools } from 'react-query/devtools';
import { ChakraProvider } from '@chakra-ui/react'
import Routers from './routes';
import theme from './utils/theme';
import useLocalStorage from './utils/storage';

const queryClient = new QueryClient();

const App = () => {
    const { storedValue } = useLocalStorage('user');
    const [isLoggedIn, setIsLoggedIn] = useState(() => !!storedValue);

    useEffect(() => {
        setIsLoggedIn(!!storedValue);
    }, [storedValue]);

    return (
        <QueryClientProvider client={queryClient}>
            <ChakraProvider theme={theme}>
                <Routers isLoggedIn={isLoggedIn} />
            </ChakraProvider>
            <ReactQueryDevtools initialIsOpen={false} />
        </QueryClientProvider>
    )
};

export default App;