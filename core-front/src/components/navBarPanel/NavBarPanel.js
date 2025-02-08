import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import Navbar from 'react-bootstrap/Navbar';
import NavDropdown from 'react-bootstrap/NavDropdown';

import useCookies from 'react-cookie';

import 'bootstrap/dist/css/bootstrap.min.css';

const NavBarPanel = () => {
    const localeList = [
        { name: 'English', code: 'en', lang: 'English' },
        { name: 'русский', code: 'ru', lang: 'Russian' }
    ];

    const [cookies, setCookie, removeCookie] = useCookies(['locale']);
  // const defaultLocale = localStorage['locale'] ? localStorage['locale'] : 'en';


  // const [currentLocale, setCurrentLocale] = useState(defaultLocale);

  // const onChangeLanguage = (e) => {
  //   const selectedLocale = e.target.value;

  //   setCurrentLocale(selectedLocale);

  //   localStorage.setItem('locale', selectedLocale)
  // }

  return (
    <Navbar expand="lg" className="bg-body-tertiary">
      <Container>
        <Navbar.Brand href="#home">Bookshop</Navbar.Brand>
        <Navbar.Toggle aria-controls="basic-navbar-nav" />
        <Navbar.Collapse id="basic-navbar-nav">
          <Nav className="me-auto">
            <Nav.Link href="#home">Home</Nav.Link>
            <Nav.Link href="#link">Link</Nav.Link>
            <NavDropdown title="Language" id="basic-nav-dropdown">
              <NavDropdown.Item href="#action/3.1">Action</NavDropdown.Item>
              <NavDropdown.Item href="#action/3.2">
                Another action
              </NavDropdown.Item>
              <NavDropdown.Item href="#action/3.3">Something</NavDropdown.Item>
              <NavDropdown.Divider />
              <NavDropdown.Item href="#action/3.4">
                Separated link
              </NavDropdown.Item>
            </NavDropdown>
          </Nav>
        </Navbar.Collapse>
      </Container>
    </Navbar>
  );
}

export default NavBarPanel;


// const localeList = [
//    { name: 'English', code: 'en', lang: 'English' },
//    { name: '中文', code: 'zh', lang: 'Chinese' },
//    { name: 'русский', code: 'ru', lang: 'Russian' },
//    { name: 'Française', code: 'fr', lang: 'French' }
// ];
// const [currentLocale, setCurrentLocale] = useState(defaultLocale);
// const onChangeLanguage = (e) => {
//    const selectedLocale = e.target.value;
//    setCurrentLocale(selectedLocale);
//    localStorage.setItem('locale',selectedLocale)
// }
// ...
// <select onChange={onChangeLanguage} defaultValue={currentLocale}>
//    {
//      localeList.map((locale,index)=>(
//       <option key={index} value={locale.code}>{locale.name}</option>
//      ))
//    }
// </select>